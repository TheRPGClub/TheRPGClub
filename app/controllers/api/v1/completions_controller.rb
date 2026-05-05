# frozen_string_literal: true

module Api
  module V1
    class CompletionsController < ApplicationController
      def index
        render_collection(UserGameCompletion.where(user_id: params[:user_id]), default_order: { completed_at: :desc })
      end

      def show
        render json: { data: UserGameCompletion.find(params[:id]).as_json }
      end

      def create
        record = UserGameCompletion.create!(request_data.merge("user_id" => params[:user_id]))
        render json: { data: record.as_json }, status: :created
      end

      def update
        record = UserGameCompletion.find(params[:id])
        record.update!(request_data)
        render json: { data: record.as_json }
      end

      def destroy
        UserGameCompletion.find(params[:id]).destroy!
        render json: { deleted: true }
      end
    end
  end
end
