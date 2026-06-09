# frozen_string_literal: true

module Api
  module V1
    class NowPlayingController < ApplicationController
      def index
        scope = UserNowPlaying.where(gamedb_game_id: params[:id]).includes(:user)
        render_collection(scope, resource: NowPlayingUserEntryResource, default_order: { added_at: :desc })
      end

      def user_index
        scope = UserNowPlaying.where(user_id: params[:user_id]).preload(:game, :platform)
        render_collection(scope, resource: NowPlayingEntryResource, default_order: { added_at: :desc })
      end
    end
  end
end
