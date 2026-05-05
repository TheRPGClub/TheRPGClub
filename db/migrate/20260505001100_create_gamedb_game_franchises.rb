# frozen_string_literal: true

class CreateGamedbGameFranchises < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_game_franchises)

    create_table :gamedb_game_franchises, id: false do |table|
      table.bigint :game_id, null: false
      table.bigint :franchise_id, null: false
    end

    execute "ALTER TABLE gamedb_game_franchises ADD PRIMARY KEY (game_id, franchise_id)"
    add_index :gamedb_game_franchises, :game_id
    add_index :gamedb_game_franchises, :franchise_id
  end

  def down
    drop_table :gamedb_game_franchises, if_exists: true
  end
end
