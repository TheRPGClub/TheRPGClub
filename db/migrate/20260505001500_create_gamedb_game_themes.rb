# frozen_string_literal: true

class CreateGamedbGameThemes < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_game_themes)

    create_table :gamedb_game_themes, id: false do |table|
      table.bigint :game_id, null: false
      table.bigint :theme_id, null: false
    end

    execute "ALTER TABLE gamedb_game_themes ADD PRIMARY KEY (game_id, theme_id)"
    add_index :gamedb_game_themes, :game_id
    add_index :gamedb_game_themes, :theme_id
  end

  def down
    drop_table :gamedb_game_themes, if_exists: true
  end
end
