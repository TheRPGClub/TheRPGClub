# frozen_string_literal: true

module Api
  module V1
    class TodosController < ApplicationController
      def index
        scope = RpgClubTodo.all
        scope = scope.where(is_completed: ActiveModel::Type::Boolean.new.cast(params[:completed])) if params[:completed].present?
        render_collection(scope, default_order: { created_at: :desc })
      end

      def show
        render json: { data: RpgClubTodo.find(params[:id]).as_json }
      end

      def create
        record = RpgClubTodo.create!(request_data)
        render json: { data: record.as_json }, status: :created
      end

      def update
        record = RpgClubTodo.find(params[:id])
        record.update!(request_data)
        render json: { data: record.as_json }
      end

      def destroy
        RpgClubTodo.find(params[:id]).destroy!
        render json: { deleted: true }
      end

      def summary
        render json: {
          data: {
            total: RpgClubTodo.count,
            completed: RpgClubTodo.where(is_completed: true).count,
            open: RpgClubTodo.where(is_completed: false).count
          }
        }
      end
    end
  end
end
