# frozen_string_literal: true

class CreateGamedbFranchises < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_franchises)

    create_table :gamedb_franchises, primary_key: :franchise_id do |table|
      table.string :name, null: false
      table.bigint :igdb_franchise_id
    end

    add_index :gamedb_franchises, :igdb_franchise_id, unique: true
  end

  def down
    drop_table :gamedb_franchises, if_exists: true
  end
end
