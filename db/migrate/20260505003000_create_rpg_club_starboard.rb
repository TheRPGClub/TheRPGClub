# frozen_string_literal: true

class CreateRpgClubStarboard < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:rpg_club_starboard)

    create_table :rpg_club_starboard, id: false do |table|
      table.string :message_id, null: false
      table.string :channel_id
      table.string :starboard_message_id
      table.string :author_id
      table.integer :star_count, default: 0, null: false
      table.datetime :created_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    end

    execute "ALTER TABLE rpg_club_starboard ADD PRIMARY KEY (message_id)"
  end

  def down
    drop_table :rpg_club_starboard, if_exists: true
  end
end
