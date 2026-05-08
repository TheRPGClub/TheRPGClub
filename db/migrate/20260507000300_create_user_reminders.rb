# frozen_string_literal: true

class CreateUserReminders < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:user_reminders)

    create_table :user_reminders, primary_key: :reminder_id do |table|
      table.string :user_id, limit: 32, null: false
      table.column :remind_at, "timestamp(6) with time zone", null: false
      table.string :content, limit: 400, null: false
      table.column :sent_at, "timestamp(6) with time zone"
      table.boolean :is_noisy, default: false, null: false
      table.bigint :failure_count, default: 0, null: false
      table.column :failed_at, "timestamp(6) with time zone"
      table.column :created_at, "timestamp(6) with time zone", default: -> { "statement_timestamp()" }, null: false
      table.column :updated_at, "timestamp(6) with time zone", default: -> { "statement_timestamp()" }, null: false
    end

    add_index :user_reminders, %i[user_id remind_at], name: "ux_user_reminders_user"
    add_index :user_reminders, %i[sent_at remind_at], name: "ux_user_reminders_due"
  end

  def down
    drop_table :user_reminders, if_exists: true
  end
end
