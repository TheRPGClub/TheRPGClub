# frozen_string_literal: true

class GamedbRelease < ApplicationRecord
  self.table_name = "gamedb_releases"
  self.primary_key = "release_id"

  belongs_to :game,
    class_name: "GamedbGame",
    foreign_key: :game_id,
    inverse_of: :releases
  belongs_to :platform,
    class_name: "GamedbPlatform",
    foreign_key: :platform_id,
    inverse_of: :releases
  belongs_to :region,
    class_name: "GamedbRegion",
    foreign_key: :region_id,
    inverse_of: :releases
  has_one :announcement,
    class_name: "GamedbReleaseAnnouncement",
    foreign_key: :release_id,
    dependent: nil,
    inverse_of: :release
end
