# frozen_string_literal: true

module Api
  module V1
    class HealthController < ApplicationController
      skip_before_action :require_authentication!

      def show
        ActiveRecord::Base.connection.select_value("SELECT 1")
        render json: { ok: true }
      end
    end
  end
end
