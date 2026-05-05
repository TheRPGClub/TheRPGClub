# frozen_string_literal: true

class CreateUserGameCompletions < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:user_game_completions)

    create_table :user_game_completions, primary_key: :completion_id do |table|
      table.string :user_id, limit: 50, null: false
      table.bigint :gamedb_game_id, null: false
      table.string :completion_type, limit: 50, null: false
      table.datetime :completed_at, precision: 6
      table.decimal :final_playtime_hrs, precision: 8, scale: 2
      table.datetime :created_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
      table.string :note, limit: 500
      table.bigint :platform_id
    end

    add_index :user_game_completions, :user_id
    add_index :user_game_completions, :gamedb_game_id
    add_index :user_game_completions, :platform_id
  end

  def down
    drop_table :user_game_completions, if_exists: true
  end
end
