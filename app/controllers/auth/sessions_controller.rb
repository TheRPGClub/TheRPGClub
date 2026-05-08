# frozen_string_literal: true

module Auth
  class SessionsController < ApplicationController
    skip_before_action :require_authentication!, only: :destroy

    def destroy
      revoke_bearer_token
      warden.logout
      reset_session
      render json: { ok: true }
    end

    private

    def revoke_bearer_token
      header = request.get_header("HTTP_AUTHORIZATION")
      return unless header&.start_with?("Bearer ")

      raw_token = header.delete_prefix("Bearer ").strip
      UserSessionToken.find_by(token: Digest::SHA256.hexdigest(raw_token))&.destroy
    end
  end
end
