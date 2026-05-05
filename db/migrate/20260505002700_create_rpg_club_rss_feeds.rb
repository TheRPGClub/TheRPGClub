# frozen_string_literal: true

class CreateRpgClubRssFeeds < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:rpg_club_rss_feeds)

    create_table :rpg_club_rss_feeds, primary_key: :feed_id do |table|
      table.string :feed_name, null: false
      table.string :feed_url, null: false
      table.string :channel_id, null: false
      table.text :include_keywords
      table.text :exclude_keywords
      table.datetime :created_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
      table.datetime :updated_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    end
  end

  def down
    drop_table :rpg_club_rss_feeds, if_exists: true
  end
end
