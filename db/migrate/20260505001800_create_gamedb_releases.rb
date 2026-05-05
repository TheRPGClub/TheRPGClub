# frozen_string_literal: true

class CreateGamedbReleases < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_releases)

    create_table :gamedb_releases, primary_key: :release_id do |table|
      table.bigint :game_id, null: false
      table.bigint :platform_id, null: false
      table.bigint :region_id, null: false
      table.string :format, limit: 20
      table.datetime :release_date, precision: 6
      table.string :notes
    end

    add_index :gamedb_releases, :game_id
    add_index :gamedb_releases, :platform_id
    add_index :gamedb_releases, :region_id
  end

  def down
    drop_table :gamedb_releases, if_exists: true
  end
end
