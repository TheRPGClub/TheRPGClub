# frozen_string_literal: true

class CreateRpgClubRssFeedItems < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:rpg_club_rss_feed_items)

    create_table :rpg_club_rss_feed_items, id: false do |table|
      table.bigint :feed_id, null: false
      table.string :item_id_hash, null: false
      table.string :title
      table.string :url, limit: 2048
      table.datetime :published_at, precision: 6
      table.datetime :created_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    end

    execute "ALTER TABLE rpg_club_rss_feed_items ADD PRIMARY KEY (feed_id, item_id_hash)"
  end

  def down
    drop_table :rpg_club_rss_feed_items, if_exists: true
  end
end
