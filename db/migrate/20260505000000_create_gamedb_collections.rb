# frozen_string_literal: true

class CreateGamedbCollections < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_collections)

    create_table :gamedb_collections, primary_key: :collection_id do |table|
      table.string :name, null: false
      table.bigint :igdb_collection_id
    end

    add_index :gamedb_collections, :igdb_collection_id, unique: true
  end

  def down
    drop_table :gamedb_collections, if_exists: true
  end
end
