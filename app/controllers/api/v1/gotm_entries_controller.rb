# frozen_string_literal: true

module Api
  module V1
    class GotmEntriesController < ApplicationController
      def index
        scope = GotmEntry.all
        scope = scope.where(round_number: params[:round_number]) if params[:round_number].present?
        render_collection(scope, default_order: { round_number: :desc, game_index: :asc })
      end

      def show
        render json: { data: GotmEntry.find(params[:id]).as_json }
      end
    end
  end
end
