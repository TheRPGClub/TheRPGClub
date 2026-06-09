# frozen_string_literal: true

module Api
  module V1
    # Per-game journal feature (bot parity, #39). Entries belong to a
    # (user, game) pair and are all public — there is no visibility concept.
    class JournalController < ApplicationController
      before_action :require_owner!, only: %i[create update destroy]

      # GET /api/v1/users/:user_id/journal
      #
      # The games a user has journaled, with per-game entry counts and the
      # last-entry timestamp, ordered by game title. One row per game (entries
      # are collapsed into a count), paginated like every other collection.
      def index
        scope = GamedbGame
          .joins("INNER JOIN user_game_journal_entries je ON je.gamedb_game_id = gamedb_games.game_id")
          .where("je.user_id = ?", params[:user_id])
          .group("gamedb_games.game_id")
          .select("gamedb_games.*, COUNT(*) AS entry_count, MAX(je.created_at) AS last_entry_at")
          .order(Arel.sql("gamedb_games.title ASC, gamedb_games.game_id ASC"))
          .preload(:images)

        # The grouped scope's `.count` returns a per-group hash, so hand pagy an
        # explicit count of the distinct journaled games.
        count = UserGameJournalEntry.where(user_id: params[:user_id]).distinct.count(:gamedb_game_id)
        pagy, games = pagy(scope, count: count, **pagy_options)

        data = games.map do |game|
          {
            "game" => GameSummaryResource.new(game).serializable_hash,
            "entry_count" => game["entry_count"],
            "last_entry_at" => game["last_entry_at"]
          }
        end

        render json: { data: data, meta: pagy_meta(pagy) }
      end

      # GET /api/v1/games/:id/journal
      #
      # Journal entries for a game across users. An optional `user_id` query
      # param narrows to a single author.
      def game_index
        scope = UserGameJournalEntry.where(gamedb_game_id: params[:id]).includes(:user)
        scope = scope.where(user_id: params[:user_id]) if params[:user_id].present?

        render_collection(scope, resource: JournalEntryUserResource,
          default_order: { created_at: :desc, entry_id: :desc })
      end

      # GET /api/v1/journal_entries/:id
      def show
        record = UserGameJournalEntry.includes(:game).find(params[:id])
        render json: { data: JournalEntryGameResource.new(record).serializable_hash }
      end

      # POST /api/v1/users/:user_id/journal
      def create
        record = UserGameJournalEntry.create!(request_data.merge("user_id" => params[:user_id]))
        record.reload
        render json: { data: JournalEntryGameResource.new(record).serializable_hash }, status: :created
      end

      # PATCH/PUT /api/v1/journal_entries/:id
      def update
        record = UserGameJournalEntry.find(params[:id])
        record.update!(request_data)
        record.reload
        render json: { data: JournalEntryGameResource.new(record).serializable_hash }
      end

      # DELETE /api/v1/journal_entries/:id
      def destroy
        UserGameJournalEntry.find(params[:id]).destroy!
        render json: { deleted: true }
      end

      private

      def resolve_owner_id
        return params[:user_id] if params[:user_id].present?
        return nil unless params[:id].present?

        UserGameJournalEntry.find_by(entry_id: params[:id])&.user_id
      end
    end
  end
end
