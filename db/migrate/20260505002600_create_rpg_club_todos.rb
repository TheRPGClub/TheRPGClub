# frozen_string_literal: true

class CreateRpgClubTodos < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:rpg_club_todos)

    create_table :rpg_club_todos, primary_key: :todo_id do |table|
      table.string :title, null: false
      table.text :details
      table.string :created_by, limit: 50
      table.datetime :created_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
      table.datetime :updated_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
      table.datetime :completed_at, precision: 6
      table.string :completed_by, limit: 50
      table.boolean :is_completed, default: false, null: false
      table.string :category, limit: 100
      table.string :todo_category, limit: 100
      table.string :todo_size, limit: 50
    end

    add_index :rpg_club_todos, :is_completed
  end

  def down
    drop_table :rpg_club_todos, if_exists: true
  end
end
