# frozen_string_literal: true

require "faraday"
require "json"

module Igdb
  class Client
    class ConfigurationError < StandardError; end
    class RequestError < StandardError; end

    TOKEN_URL = "https://id.twitch.tv/oauth2/token"
    API_BASE_URL = "https://api.igdb.com/v4"
    IMAGE_BASE_URL = "https://images.igdb.com/igdb/image/upload"

    def self.image_url(image_id, size:, extension: "jpg")
      "#{IMAGE_BASE_URL}/t_#{size}/#{image_id}.#{extension}"
    end

    def game_images(igdb_id)
      payload = post_igdb(
        "games",
        <<~QUERY.squish
          fields id,name,cover.image_id,artworks.image_id,artworks.alpha_channel,artworks.artwork_type.slug;
          where id = #{Integer(igdb_id)};
          limit 1;
        QUERY
      )
      game = payload.first
      return if game.blank?

      {
        igdb_id: game["id"],
        title: game["name"],
        cover_image_id: game.dig("cover", "image_id"),
        artworks: Array(game["artworks"]).filter_map { |artwork| artwork_hash(artwork) }
      }
    end

    private

    def artwork_hash(artwork)
      image_id = artwork["image_id"].presence
      return if image_id.blank?

      {
        image_id: image_id,
        alpha_channel: artwork["alpha_channel"] == true,
        artwork_type_slug: artwork.dig("artwork_type", "slug").to_s
      }
    end

    def post_igdb(path, body)
      response = Faraday.post("#{API_BASE_URL}/#{path}") do |request|
        request.headers["Client-ID"] = client_id
        request.headers["Authorization"] = "Bearer #{access_token}"
        request.headers["Content-Type"] = "text/plain"
        request.body = body
        request.options.timeout = 20
      end

      parse_json_response!(response, "IGDB #{path} request")
    end

    def access_token
      return @access_token if @access_token.present? && Time.current < @access_token_expires_at

      response = Faraday.post(TOKEN_URL) do |request|
        request.headers["Content-Type"] = "application/x-www-form-urlencoded"
        request.body = {
          client_id: client_id,
          client_secret: client_secret,
          grant_type: "client_credentials"
        }.to_query
        request.options.timeout = 20
      end

      payload = parse_json_response!(response, "IGDB token request")
      @access_token = payload.fetch("access_token")
      @access_token_expires_at = Time.current + payload.fetch("expires_in").to_i - 60
      @access_token
    end

    def client_id
      value = ENV.fetch("IGDB_CLIENT_ID", ENV.fetch("TWITCH_CLIENT_ID", nil)).to_s.strip
      return value if value.present? && value != "change_me"

      raise ConfigurationError, "IGDB_CLIENT_ID must be set"
    end

    def client_secret
      value = ENV.fetch("IGDB_CLIENT_SECRET", ENV.fetch("TWITCH_CLIENT_SECRET", nil)).to_s.strip
      return value if value.present? && value != "change_me"

      raise ConfigurationError, "IGDB_CLIENT_SECRET must be set"
    end

    def parse_json_response!(response, label)
      payload = JSON.parse(response.body)
      return payload if response.success?

      raise RequestError, "#{label} failed with HTTP #{response.status}: #{error_message(payload)}"
    rescue JSON::ParserError
      raise RequestError, "#{label} failed with HTTP #{response.status}"
    end

    def error_message(payload)
      return payload.to_json unless payload.is_a?(Hash)

      payload["message"] || payload["error_description"] || payload["error"] || payload.to_json
    end
  end
end
