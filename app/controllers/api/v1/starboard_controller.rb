# frozen_string_literal: true

module Api
  module V1
    class StarboardController < ApplicationController
      def index
        render_collection(RpgClubStarboardEntry.all, default_order: { created_at: :desc })
      end

      def show
        render json: { data: RpgClubStarboardEntry.find(params[:message_id]).as_json }
      end

      def create
        record = RpgClubStarboardEntry.create!(request_data)
        render json: { data: record.as_json }, status: :created
      end

      def update
        record = RpgClubStarboardEntry.find(params[:message_id])
        record.update!(request_data)
        render json: { data: record.as_json }
      end

      def destroy
        RpgClubStarboardEntry.find(params[:message_id]).destroy!
        render json: { deleted: true }
      end
    end
  end
end
