# frozen_string_literal: true

class CreateGamedbRegions < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_regions)

    create_table :gamedb_regions, primary_key: :region_id do |table|
      table.string :region_code, limit: 10, null: false
      table.string :region_name, limit: 100, null: false
      table.bigint :igdb_region_id
    end

    add_index :gamedb_regions, :region_code, unique: true
    add_index :gamedb_regions, :igdb_region_id, unique: true
  end

  def down
    drop_table :gamedb_regions, if_exists: true
  end
end
