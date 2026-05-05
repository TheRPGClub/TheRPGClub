# frozen_string_literal: true

class GamedbPerspective < ApplicationRecord
  self.table_name = "gamedb_perspectives"
  self.primary_key = "perspective_id"

  has_many :game_perspectives,
    class_name: "GamedbGamePerspective",
    foreign_key: :perspective_id,
    dependent: nil,
    inverse_of: :perspective
  has_many :games,
    through: :game_perspectives,
    source: :game

  validates :name, presence: true
end
