# frozen_string_literal: true

module Api
  module V1
    class VotingInfoController < ApplicationController
      def index
        render_collection(BotVotingInfo.all, default_order: { round_number: :desc })
      end

      def show
        render json: { data: BotVotingInfo.find(params[:id]).as_json }
      end

      def create
        record = BotVotingInfo.create!(request_data)
        render json: { data: record.as_json }, status: :created
      end

      def update
        record = BotVotingInfo.find(params[:id])
        record.update!(request_data)
        render json: { data: record.as_json }
      end

      def destroy
        BotVotingInfo.find(params[:id]).destroy!
        render json: { deleted: true }
      end
    end
  end
end
