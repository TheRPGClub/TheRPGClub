# frozen_string_literal: true

class CreateGamedbPerspectives < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_perspectives)

    create_table :gamedb_perspectives, primary_key: :perspective_id do |table|
      table.string :name, null: false
      table.bigint :igdb_perspective_id
    end

    add_index :gamedb_perspectives, :igdb_perspective_id, unique: true
  end

  def down
    drop_table :gamedb_perspectives, if_exists: true
  end
end
