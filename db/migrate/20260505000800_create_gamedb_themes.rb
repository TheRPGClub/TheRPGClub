# frozen_string_literal: true

class CreateGamedbThemes < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_themes)

    create_table :gamedb_themes, primary_key: :theme_id do |table|
      table.string :name, null: false
      table.bigint :igdb_theme_id
    end

    add_index :gamedb_themes, :igdb_theme_id, unique: true
  end

  def down
    drop_table :gamedb_themes, if_exists: true
  end
end
