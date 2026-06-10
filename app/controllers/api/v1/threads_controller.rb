# frozen_string_literal: true

module Api
  module V1
    # Discord threads the bot maps to games (#45). Read-only: the bot owns every
    # thread/link write, so the API just resolves the `thread_game_links` table
    # for a game. Reads are open to any authenticated caller, matching the rest
    # of the bot-managed read endpoints.
    class ThreadsController < ApplicationController
      # GET /api/v1/games/:id/threads
      #
      # The threads linked to the game through `thread_game_links` (a thread can
      # be linked to several games), newest thread first.
      def game_index
        scope = DiscordThread
          .joins(:thread_game_links)
          .where(thread_game_links: { gamedb_game_id: params[:id] })
        render_collection(scope, resource: ThreadResource, default_order: { created_at: :desc })
      end
    end
  end
end
