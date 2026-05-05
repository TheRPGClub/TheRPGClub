# frozen_string_literal: true

class CreateBotVotingInfo < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:bot_voting_info)

    create_table :bot_voting_info, id: false do |table|
      table.integer :round_number, null: false
      table.string :nomination_list_id
      table.datetime :next_vote_at, precision: 6
      table.boolean :five_day_reminder_sent, default: false, null: false
      table.boolean :one_day_reminder_sent, default: false, null: false
    end

    execute "ALTER TABLE bot_voting_info ADD PRIMARY KEY (round_number)"
  end

  def down
    drop_table :bot_voting_info, if_exists: true
  end
end
