# frozen_string_literal: true

class CreateGamedbGenres < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_genres)

    create_table :gamedb_genres, primary_key: :genre_id do |table|
      table.string :name, null: false
      table.bigint :igdb_genre_id
    end

    add_index :gamedb_genres, :igdb_genre_id, unique: true
  end

  def down
    drop_table :gamedb_genres, if_exists: true
  end
end
