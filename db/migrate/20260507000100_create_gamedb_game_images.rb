# frozen_string_literal: true

class CreateGamedbGameImages < ActiveRecord::Migration[8.1]
  def change
    create_table :gamedb_game_images, primary_key: :image_id do |table|
      table.bigint :game_id, null: false
      table.string :kind, null: false, limit: 32
      table.string :object_key, null: false, limit: 512
      table.string :uploaded_by_user_id, limit: 30
      table.boolean :is_primary, null: false, default: false
      table.integer :position, null: false, default: 1
      table.timestamps precision: 6, default: -> { "CURRENT_TIMESTAMP" }
    end

    add_foreign_key :gamedb_game_images, :gamedb_games, column: :game_id, primary_key: :game_id, name: "fk_rails_gamedb_game_images_game"
    add_foreign_key :gamedb_game_images, :rpg_club_users, column: :uploaded_by_user_id, primary_key: :user_id, name: "fk_rails_gamedb_game_images_uploaded_by"
    add_check_constraint :gamedb_game_images, "kind IN ('cover', 'artwork', 'logo')", name: "ck_gamedb_game_images_kind"

    add_index :gamedb_game_images, [ :game_id, :kind, :position ], name: "idx_gamedb_game_images_lookup"
    add_index :gamedb_game_images, :object_key, unique: true
    add_index :gamedb_game_images,
      [ :game_id, :kind ],
      unique: true,
      where: "is_primary = true",
      name: "idx_gamedb_game_images_one_primary"
  end
end
