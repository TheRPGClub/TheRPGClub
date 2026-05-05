# frozen_string_literal: true

class RpgClubRssFeedItem < ApplicationRecord
  self.table_name = "rpg_club_rss_feed_items"
  self.primary_key = %i[feed_id item_id_hash]

  belongs_to :feed,
    class_name: "RpgClubRssFeed",
    foreign_key: :feed_id,
    inverse_of: :items
end
