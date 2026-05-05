# frozen_string_literal: true

module Api
  module V1
    class NrGotmEntriesController < ApplicationController
      def index
        scope = NrGotmEntry.all
        scope = scope.where(round_number: params[:round_number]) if params[:round_number].present?
        render_collection(scope, default_order: { round_number: :desc, game_index: :asc })
      end

      def show
        render json: { data: NrGotmEntry.find(params[:id]).as_json }
      end
    end
  end
end
