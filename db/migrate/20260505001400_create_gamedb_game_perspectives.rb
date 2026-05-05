# frozen_string_literal: true

class CreateGamedbGamePerspectives < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_game_perspectives)

    create_table :gamedb_game_perspectives, id: false do |table|
      table.bigint :game_id, null: false
      table.bigint :perspective_id, null: false
    end

    execute "ALTER TABLE gamedb_game_perspectives ADD PRIMARY KEY (game_id, perspective_id)"
    add_index :gamedb_game_perspectives, :game_id
    add_index :gamedb_game_perspectives, :perspective_id
  end

  def down
    drop_table :gamedb_game_perspectives, if_exists: true
  end
end
