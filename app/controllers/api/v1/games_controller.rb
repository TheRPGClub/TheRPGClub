# frozen_string_literal: true

module Api
  module V1
    class GamesController < ApplicationController
      def index
        scope = params[:q].present? ? GamedbGame.search(params[:q]) : GamedbGame.without_images.order(:title)
        records = scope.limit(limit).offset(offset)

        render json: {
          data: records.as_json,
          meta: {
            resource: "gamedb_games",
            limit: limit,
            offset: offset
          }
        }
      end

      def show
        render json: { data: GamedbGame.without_images.find(params[:id]).as_json }
      end

      def image
        column = params[:kind] == "art" ? "art_data" : "image_data"
        data = GamedbGame.select(column).find(params[:id]).public_send(column)
        return render(json: { error: "image_not_found" }, status: :not_found) if data.blank?

        send_data data, type: "image/jpeg", disposition: "inline"
      end

      def releases
        render json: { data: releases_for(GamedbGame.find(params[:id])) }
      end

      def relations
        game = GamedbGame.find(params[:id])
        render json: {
          data: {
            platforms: game.platforms.order(:platform_name).as_json,
            releases: releases_for(game),
            companies: companies_for(game),
            franchises: game.franchises.order(:name).as_json,
            genres: game.genres.order(:name).as_json,
            modes: game.modes.order(:name).as_json,
            perspectives: game.perspectives.order(:name).as_json,
            themes: game.themes.order(:name).as_json,
            alternates: game.alternate_games.as_json
          }
        }
      end

      private

      def releases_for(game)
        game
          .releases
          .includes(:platform, :region)
          .sort_by { |release| [ release.release_date || Date.new(9999, 12, 31), release.platform.platform_name, release.region.region_name ] }
          .map { |release| release_json(release) }
      end

      def release_json(release)
        release.as_json.merge(
          "platform_code" => release.platform.platform_code,
          "platform_name" => release.platform.platform_name,
          "region_code" => release.region.region_code,
          "region_name" => release.region.region_name
        )
      end

      def companies_for(game)
        game.game_companies.includes(:company).sort_by { |game_company| game_company.company.name.to_s }.map do |game_company|
          game_company.company.as_json.merge("role" => game_company.role)
        end
      end

      def limit
        [ [ params.fetch(:limit, 25).to_i, 1 ].max, 100 ].min
      end

      def offset
        [ params.fetch(:offset, 0).to_i, 0 ].max
      end
    end
  end
end
