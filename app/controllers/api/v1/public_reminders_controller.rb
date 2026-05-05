# frozen_string_literal: true

module Api
  module V1
    class PublicRemindersController < ApplicationController
      def index
        scope = RpgClubPublicReminder.all
        scope = scope.where(enabled: ActiveModel::Type::Boolean.new.cast(params[:enabled])) if params[:enabled].present?
        render_collection(scope, default_order: { due_at: :asc })
      end

      def show
        render json: { data: RpgClubPublicReminder.find(params[:id]).as_json }
      end

      def create
        record = RpgClubPublicReminder.create!(request_data)
        render json: { data: record.as_json }, status: :created
      end

      def update
        record = RpgClubPublicReminder.find(params[:id])
        record.update!(request_data)
        render json: { data: record.as_json }
      end

      def destroy
        RpgClubPublicReminder.find(params[:id]).destroy!
        render json: { deleted: true }
      end
    end
  end
end
