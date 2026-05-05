# frozen_string_literal: true

class CreateGamedbGamePlatforms < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_game_platforms)

    create_table :gamedb_game_platforms, id: false do |table|
      table.bigint :game_id, null: false
      table.bigint :platform_id, null: false
    end

    execute "ALTER TABLE gamedb_game_platforms ADD PRIMARY KEY (game_id, platform_id)"
    add_index :gamedb_game_platforms, :game_id
    add_index :gamedb_game_platforms, :platform_id
  end

  def down
    drop_table :gamedb_game_platforms, if_exists: true
  end
end
