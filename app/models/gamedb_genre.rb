# frozen_string_literal: true

class GamedbGenre < ApplicationRecord
  self.table_name = "gamedb_genres"
  self.primary_key = "genre_id"

  has_many :game_genres,
    class_name: "GamedbGameGenre",
    foreign_key: :genre_id,
    dependent: nil,
    inverse_of: :genre
  has_many :games,
    through: :game_genres,
    source: :game

  validates :name, presence: true
end
