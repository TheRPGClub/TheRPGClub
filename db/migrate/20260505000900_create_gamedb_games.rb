# frozen_string_literal: true

class CreateGamedbGames < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_games)

    create_table :gamedb_games, primary_key: :game_id do |table|
      table.string :title, null: false
      table.text :description
      table.boolean :thumbnail_bad, default: false, null: false
      table.boolean :thumbnail_approved, default: false, null: false
      table.bigint :igdb_id
      table.string :slug
      table.decimal :total_rating
      table.string :igdb_url, limit: 512
      table.string :featured_video_url, limit: 512
      table.bigint :collection_id
      table.bigint :parent_igdb_id
      table.string :parent_game_name
      table.datetime :initial_release_date, precision: 6
      table.datetime :created_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }
      table.datetime :updated_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }
    end

    add_index :gamedb_games, :igdb_id, unique: true
  end

  def down
    drop_table :gamedb_games, if_exists: true
  end
end
