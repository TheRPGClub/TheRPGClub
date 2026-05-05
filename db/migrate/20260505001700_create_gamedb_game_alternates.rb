# frozen_string_literal: true

class CreateGamedbGameAlternates < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_game_alternates)

    create_table :gamedb_game_alternates, id: false do |table|
      table.bigint :game_id, null: false
      table.bigint :alt_game_id, null: false
      table.datetime :created_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
      table.string :created_by, limit: 64
    end

    execute "ALTER TABLE gamedb_game_alternates ADD PRIMARY KEY (game_id, alt_game_id)"
  end

  def down
    drop_table :gamedb_game_alternates, if_exists: true
  end
end
