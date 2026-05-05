# frozen_string_literal: true

class GamedbGamePlatform < ApplicationRecord
  self.table_name = "gamedb_game_platforms"
  self.primary_key = %i[game_id platform_id]

  belongs_to :game,
    class_name: "GamedbGame",
    foreign_key: :game_id,
    inverse_of: :game_platforms
  belongs_to :platform,
    class_name: "GamedbPlatform",
    foreign_key: :platform_id,
    inverse_of: :game_platforms
end
