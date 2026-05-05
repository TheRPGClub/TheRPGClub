# frozen_string_literal: true

class GamedbRegion < ApplicationRecord
  self.table_name = "gamedb_regions"
  self.primary_key = "region_id"

  has_many :releases,
    class_name: "GamedbRelease",
    foreign_key: :region_id,
    dependent: nil,
    inverse_of: :region

  validates :region_code, :region_name, presence: true
end
