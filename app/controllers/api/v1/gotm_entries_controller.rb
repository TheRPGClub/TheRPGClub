# frozen_string_literal: true

module Api
  module V1
    class GotmEntriesController < ApplicationController
      def index
        scope = GotmEntry.all
        scope = scope.where(round_number: params[:round_number]) if params[:round_number].present?
        scope = scope.preload(game: :images) if include_game?
        render_collection(scope, default_order: { round_number: :desc, game_index: :asc })
      end

      def show
        scope = include_game? ? GotmEntry.preload(game: :images) : GotmEntry
        render json: { data: scope.find(params[:id]).as_json }
      end

      private

      def include_game?
        params[:include].to_s.split(",").map(&:strip).include?("game")
      end
    end
  end
end
