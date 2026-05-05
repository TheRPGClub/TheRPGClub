# frozen_string_literal: true

class GamedbGamePerspective < ApplicationRecord
  self.table_name = "gamedb_game_perspectives"
  self.primary_key = %i[game_id perspective_id]

  belongs_to :game,
    class_name: "GamedbGame",
    foreign_key: :game_id,
    inverse_of: :game_perspectives
  belongs_to :perspective,
    class_name: "GamedbPerspective",
    foreign_key: :perspective_id,
    inverse_of: :game_perspectives
end
