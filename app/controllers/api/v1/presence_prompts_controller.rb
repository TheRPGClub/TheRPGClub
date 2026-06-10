# frozen_string_literal: true

module Api
  module V1
    # Per-user presence prompt history (bot parity, #48). Read-only: the bot's
    # presence-detection loop owns every write (creating a prompt and later
    # marking it resolved). The user-settable opt-out preference lives in
    # PresencePromptOptsController.
    class PresencePromptsController < ApplicationController
      # GET /api/v1/users/:user_id/presence_prompts
      def index
        scope = PresencePrompt.where(user_id: params[:user_id])
        render_collection(scope, resource: PresencePromptResource,
          default_order: { created_at: :desc, prompt_id: :desc })
      end
    end
  end
end
