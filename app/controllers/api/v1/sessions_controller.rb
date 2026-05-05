# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      def show
        user = RpgClubUser.find_by(user_id: current_principal.discord_id) if current_principal.discord_user?

        render json: {
          principal: current_principal,
          membership: user&.membership
        }
      end
    end
  end
end
