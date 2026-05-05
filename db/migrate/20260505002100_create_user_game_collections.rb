# frozen_string_literal: true

class CreateUserGameCollections < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:user_game_collections)

    create_table :user_game_collections, primary_key: :entry_id do |table|
      table.string :user_id, limit: 50, null: false
      table.bigint :gamedb_game_id, null: false
      table.bigint :platform_id
      table.string :ownership_type, limit: 30, default: "Digital", null: false
      table.string :note, limit: 500
      table.boolean :is_shared, default: true, null: false
      table.datetime :created_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
      table.datetime :updated_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    end

    add_index :user_game_collections, :user_id
    add_index :user_game_collections, :gamedb_game_id
    add_index :user_game_collections, :platform_id
  end

  def down
    drop_table :user_game_collections, if_exists: true
  end
end
