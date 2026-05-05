# frozen_string_literal: true

class CreateGamedbPlatforms < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_platforms)

    create_table :gamedb_platforms, primary_key: :platform_id do |table|
      table.string :platform_code, limit: 20, null: false
      table.string :platform_name, limit: 100, null: false
      table.bigint :igdb_platform_id
      table.string :platform_abbreviation, limit: 50
      table.string :platform_slug
      table.string :platform_checksum, limit: 64
      table.bigint :igdb_updated_at
    end

    add_index :gamedb_platforms, :platform_code, unique: true
    add_index :gamedb_platforms, :igdb_platform_id, unique: true
  end

  def down
    drop_table :gamedb_platforms, if_exists: true
  end
end
