# frozen_string_literal: true

module Auth
  class SessionsController < ApplicationController
    skip_before_action :require_authentication!, only: :destroy

    def destroy
      warden.logout
      reset_session
      render json: { ok: true }
    end
  end
end
