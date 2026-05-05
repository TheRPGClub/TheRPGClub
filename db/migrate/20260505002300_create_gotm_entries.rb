# frozen_string_literal: true

class CreateGotmEntries < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gotm_entries)

    create_table :gotm_entries, primary_key: :gotm_id do |table|
      table.integer :round_number, null: false
      table.string :month_year, null: false
      table.integer :game_index, null: false
      table.string :game_title, null: false
      table.bigint :gamedb_game_id
      table.string :reddit_url, limit: 2048
      table.string :voting_results_message_id
    end

    add_index :gotm_entries, %i[round_number game_index], unique: true
  end

  def down
    drop_table :gotm_entries, if_exists: true
  end
end
