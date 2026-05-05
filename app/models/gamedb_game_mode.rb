# frozen_string_literal: true

class GamedbGameMode < ApplicationRecord
  self.table_name = "gamedb_game_modes"
  self.primary_key = %i[game_id mode_id]

  belongs_to :game,
    class_name: "GamedbGame",
    foreign_key: :game_id,
    inverse_of: :game_modes
  belongs_to :mode,
    class_name: "GamedbGameModeDef",
    foreign_key: :mode_id,
    inverse_of: :game_modes
end
