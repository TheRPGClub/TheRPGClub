# frozen_string_literal: true

module Api
  module V1
    class RssFeedsController < ApplicationController
      def index
        render_collection(RpgClubRssFeed.all, default_order: { feed_name: :asc })
      end

      def show
        render json: { data: RpgClubRssFeed.find(params[:id]).as_json }
      end

      def create
        record = RpgClubRssFeed.create!(request_data)
        render json: { data: record.as_json }, status: :created
      end

      def update
        record = RpgClubRssFeed.find(params[:id])
        record.update!(request_data)
        render json: { data: record.as_json }
      end

      def destroy
        RpgClubRssFeed.find(params[:id]).destroy!
        render json: { deleted: true }
      end
    end
  end
end
