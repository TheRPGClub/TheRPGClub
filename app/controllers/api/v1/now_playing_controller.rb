# frozen_string_literal: true

module Api
  module V1
    class NowPlayingController < ApplicationController
      def index
        entries = UserNowPlaying
          .where(gamedb_game_id: params[:id])
          .includes(:user)
          .order(added_at: :desc)
          .limit(pagination_limit)
          .offset(pagination_offset)

        render json: {
          data: entries.map { |e| e.as_json.merge("user" => e.user&.as_json(except: RpgClubUser::BINARY_COLUMNS)) },
          meta: { limit: pagination_limit, offset: pagination_offset }
        }
      end
    end
  end
end
