# frozen_string_literal: true

class GamedbTheme < ApplicationRecord
  self.table_name = "gamedb_themes"
  self.primary_key = "theme_id"

  has_many :game_themes,
    class_name: "GamedbGameTheme",
    foreign_key: :theme_id,
    dependent: nil,
    inverse_of: :theme
  has_many :games,
    through: :game_themes,
    source: :game

  validates :name, presence: true
end
