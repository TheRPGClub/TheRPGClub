# frozen_string_literal: true

class CreateUserGameReviews < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:user_game_reviews)

    create_table :user_game_reviews, primary_key: :review_id do |table|
      table.string :user_id, limit: 50, null: false
      table.bigint :gamedb_game_id, null: false
      table.integer :rating, null: false
      table.jsonb :body
      table.boolean :is_shared, default: true, null: false
      table.datetime :created_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
      table.datetime :updated_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    end

    add_check_constraint :user_game_reviews,
                         "rating BETWEEN 0 AND 100",
                         name: "ck_user_game_reviews_rating_range"

    add_index :user_game_reviews, %i[user_id gamedb_game_id],
              unique: true,
              name: "uq_user_game_reviews_user_game"
    add_index :user_game_reviews, :user_id,
              name: "ix_user_game_reviews_user"
    add_index :user_game_reviews, :gamedb_game_id,
              name: "ix_user_game_reviews_game"

    add_foreign_key :user_game_reviews,
                    :gamedb_games,
                    column: :gamedb_game_id,
                    primary_key: :game_id,
                    name: "fk_user_game_reviews_gamedb"
    add_foreign_key :user_game_reviews,
                    :rpg_club_users,
                    column: :user_id,
                    primary_key: :user_id,
                    name: "fk_user_game_reviews_user"
  end

  def down
    drop_table :user_game_reviews, if_exists: true
  end
end
