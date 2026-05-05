# frozen_string_literal: true

class GamedbFranchise < ApplicationRecord
  self.table_name = "gamedb_franchises"
  self.primary_key = "franchise_id"

  has_many :game_franchises,
    class_name: "GamedbGameFranchise",
    foreign_key: :franchise_id,
    dependent: nil,
    inverse_of: :franchise
  has_many :games,
    through: :game_franchises,
    source: :game

  validates :name, presence: true
end
