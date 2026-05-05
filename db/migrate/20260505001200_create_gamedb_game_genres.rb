# frozen_string_literal: true

class CreateGamedbGameGenres < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_game_genres)

    create_table :gamedb_game_genres, id: false do |table|
      table.bigint :game_id, null: false
      table.bigint :genre_id, null: false
    end

    execute "ALTER TABLE gamedb_game_genres ADD PRIMARY KEY (game_id, genre_id)"
    add_index :gamedb_game_genres, :game_id
    add_index :gamedb_game_genres, :genre_id
  end

  def down
    drop_table :gamedb_game_genres, if_exists: true
  end
end
