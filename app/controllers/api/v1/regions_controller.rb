# frozen_string_literal: true

module Api
  module V1
    class RegionsController < ApplicationController
      def index
        render_collection(GamedbRegion.all, default_order: { region_name: :asc })
      end

      def show
        render json: { data: GamedbRegion.find(params[:id]).as_json }
      end
    end
  end
end
