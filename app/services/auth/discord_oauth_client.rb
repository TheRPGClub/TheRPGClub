# frozen_string_literal: true

require "faraday"

module Auth
  class DiscordOauthClient
    class ConfigurationError < StandardError; end

    AUTHORIZE_URL = "https://discord.com/oauth2/authorize"
    TOKEN_URL = "https://discord.com/api/oauth2/token"
    USER_URL = "https://discord.com/api/users/@me"

    def authorization_url(state:, redirect_uri:)
      query = {
        client_id: client_id,
        redirect_uri: redirect_uri,
        response_type: "code",
        scope: ENV.fetch("DISCORD_OAUTH_SCOPES", "identify email"),
        state: state,
        prompt: "none"
      }.to_query

      "#{AUTHORIZE_URL}?#{query}"
    end

    def exchange_code!(code:, redirect_uri:)
      response = Faraday.post(TOKEN_URL) do |request|
        request.headers["Content-Type"] = "application/x-www-form-urlencoded"
        request.body = {
          client_id: client_id,
          client_secret: client_secret,
          grant_type: "authorization_code",
          code: code,
          redirect_uri: redirect_uri
        }.to_query
      end

      parse_response!(response)
    end

    def fetch_user!(access_token)
      response = Faraday.get(USER_URL) do |request|
        request.headers["Authorization"] = "Bearer #{access_token}"
      end

      parse_response!(response)
    end

    private

    def client_id
      value = ENV.fetch("DISCORD_CLIENT_ID", nil).to_s.strip
      return value if value.match?(/\A\d+\z/)

      raise ConfigurationError, "DISCORD_CLIENT_ID must be the numeric Discord application client ID"
    end

    def client_secret
      value = ENV.fetch("DISCORD_CLIENT_SECRET", nil).to_s.strip
      return value if value.present? && value != "change_me"

      raise ConfigurationError, "DISCORD_CLIENT_SECRET must be set from the Discord application OAuth2 settings"
    end

    def parse_response!(response)
      payload = JSON.parse(response.body)
      return payload if response.success?

      raise StandardError, discord_error_message(payload)
    rescue JSON::ParserError
      raise StandardError, "Discord OAuth request failed with HTTP #{response.status}"
    end

    def discord_error_message(payload)
      [
        payload["error_description"],
        payload["message"],
        payload["error"],
        nested_error_messages(payload["errors"])
      ].compact_blank.join(": ").presence || "Discord OAuth request failed"
    end

    def nested_error_messages(errors)
      return if errors.blank?

      errors.to_json
    end
  end
end
