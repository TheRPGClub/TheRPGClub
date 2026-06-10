# frozen_string_literal: true

module Api
  module V1
    # A user's presence-prompt opt-out preference (bot parity, #48), exposed as
    # a single document rather than individual composite-key rows. GET reads it;
    # PUT replaces it wholesale. Reads are open; the PUT is owner-only.
    class PresencePromptOptsController < ApplicationController
      before_action :require_owner!, only: %i[update]

      # GET /api/v1/users/:user_id/presence_prompt_opts
      def show
        render json: { data: preference(params[:user_id]) }
      end

      # PUT /api/v1/users/:user_id/presence_prompt_opts
      #
      # Replaces the user's entire opt-out set. Body:
      #   { "data": { "all": true, "games": ["Final Fantasy VII", ...] } }
      # `all` toggles the silence-everything row; `games` lists the titles to
      # silence individually (normalized like the bot; blanks and duplicates
      # dropped). An empty/omitted set clears the user's opt-outs (opt back in).
      def update
        user_id = params[:user_id]
        data = request_data

        PresencePromptOpt.transaction do
          PresencePromptOpt.where(user_id: user_id).delete_all
          rebuild_opts(user_id, data)
        end

        render json: { data: preference(user_id) }
      end

      private

      def rebuild_opts(user_id, data)
        if ActiveModel::Type::Boolean.new.cast(data["all"])
          PresencePromptOpt.create!(
            user_id: user_id,
            scope: PresencePromptOpt::SCOPE_ALL,
            game_title: nil,
            game_title_norm: PresencePromptOpt::ALL_TOKEN
          )
        end

        seen = []
        Array(data["games"]).each do |title|
          norm = PresencePromptOpt.normalize_title(title)
          next if norm.blank? || seen.include?(norm)

          seen << norm
          PresencePromptOpt.create!(
            user_id: user_id,
            scope: PresencePromptOpt::SCOPE_GAME,
            game_title: title.to_s,
            game_title_norm: norm
          )
        end
      end

      # The user's opt-out preference as a single document: whether they've
      # silenced every game (`all`) plus the per-game opt-outs.
      def preference(user_id)
        rows = PresencePromptOpt.where(user_id: user_id).order(:scope, :game_title_norm)

        {
          user_id: user_id,
          all: rows.any? { |row| row.scope == PresencePromptOpt::SCOPE_ALL },
          games: rows.select { |row| row.scope == PresencePromptOpt::SCOPE_GAME }.map do |row|
            {
              game_title: row.game_title,
              game_title_norm: row.game_title_norm,
              created_at: row.created_at
            }
          end
        }
      end
    end
  end
end
