# frozen_string_literal: true

class GamedbGameModeDef < ApplicationRecord
  self.table_name = "gamedb_game_modes_def"
  self.primary_key = "mode_id"

  has_many :game_modes,
    class_name: "GamedbGameMode",
    foreign_key: :mode_id,
    dependent: nil,
    inverse_of: :mode
  has_many :games,
    through: :game_modes,
    source: :game

  validates :name, presence: true
end
