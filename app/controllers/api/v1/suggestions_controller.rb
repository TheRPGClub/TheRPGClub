# frozen_string_literal: true

module Api
  module V1
    class SuggestionsController < ApplicationController
      def index
        render_collection(RpgClubSuggestion.all, default_order: { created_at: :desc })
      end

      def show
        render json: { data: RpgClubSuggestion.find(params[:id]).as_json }
      end

      def create
        record = RpgClubSuggestion.create!(request_data)
        render json: { data: record.as_json }, status: :created
      end

      def destroy
        RpgClubSuggestion.find(params[:id]).destroy!
        render json: { deleted: true }
      end
    end
  end
end
