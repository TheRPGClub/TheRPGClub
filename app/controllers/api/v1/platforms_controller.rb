# frozen_string_literal: true

module Api
  module V1
    class PlatformsController < ApplicationController
      def index
        scope = GamedbPlatform.all
        scope = scope.where("platform_name ILIKE :term OR platform_code ILIKE :term", term: "%#{query}%") if params[:q].present?

        render_collection(scope, default_order: { platform_name: :asc })
      end

      def show
        render json: { data: GamedbPlatform.find(params[:id]).as_json }
      end

      private

      def query
        ActiveRecord::Base.sanitize_sql_like(params[:q].to_s.strip)
      end
    end
  end
end
