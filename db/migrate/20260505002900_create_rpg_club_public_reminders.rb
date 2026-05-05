# frozen_string_literal: true

class CreateRpgClubPublicReminders < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:rpg_club_public_reminders)

    create_table :rpg_club_public_reminders, primary_key: :reminder_id do |table|
      table.string :channel_id, null: false
      table.text :message, null: false
      table.datetime :due_at, precision: 6, null: false
      table.integer :recur_every
      table.string :recur_unit, limit: 20
      table.boolean :enabled, default: true, null: false
      table.string :created_by, limit: 50
      table.datetime :created_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
      table.datetime :updated_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    end

    add_index :rpg_club_public_reminders, :due_at
  end

  def down
    drop_table :rpg_club_public_reminders, if_exists: true
  end
end
