# frozen_string_literal: true

class CreateGamedbGameModesDef < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_game_modes_def)

    create_table :gamedb_game_modes_def, primary_key: :mode_id do |table|
      table.string :name, null: false
      table.bigint :igdb_game_mode_id
    end

    add_index :gamedb_game_modes_def, :igdb_game_mode_id, unique: true
  end

  def down
    drop_table :gamedb_game_modes_def, if_exists: true
  end
end
