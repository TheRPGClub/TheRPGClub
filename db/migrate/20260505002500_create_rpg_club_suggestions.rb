# frozen_string_literal: true

class CreateRpgClubSuggestions < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:rpg_club_suggestions)

    create_table :rpg_club_suggestions, primary_key: :suggestion_id do |table|
      table.string :title, null: false
      table.text :description
      table.string :suggested_by, limit: 50
      table.datetime :created_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    end
  end

  def down
    drop_table :rpg_club_suggestions, if_exists: true
  end
end
