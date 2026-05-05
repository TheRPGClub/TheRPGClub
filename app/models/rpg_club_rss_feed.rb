# frozen_string_literal: true

class RpgClubRssFeed < ApplicationRecord
  self.table_name = "rpg_club_rss_feeds"
  self.primary_key = "feed_id"

  has_many :items,
    class_name: "RpgClubRssFeedItem",
    foreign_key: :feed_id,
    dependent: nil,
    inverse_of: :feed

  validates :feed_name, :feed_url, :channel_id, presence: true
end
