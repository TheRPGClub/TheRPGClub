# frozen_string_literal: true

class CreateGamedbGameModes < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_game_modes)

    create_table :gamedb_game_modes, id: false do |table|
      table.bigint :game_id, null: false
      table.bigint :mode_id, null: false
    end

    execute "ALTER TABLE gamedb_game_modes ADD PRIMARY KEY (game_id, mode_id)"
    add_index :gamedb_game_modes, :game_id
    add_index :gamedb_game_modes, :mode_id
  end

  def down
    drop_table :gamedb_game_modes, if_exists: true
  end
end
