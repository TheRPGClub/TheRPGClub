# frozen_string_literal: true

class GamedbGameAlternate < ApplicationRecord
  self.table_name = "gamedb_game_alternates"
  self.primary_key = %i[game_id alt_game_id]

  belongs_to :game,
    class_name: "GamedbGame",
    foreign_key: :game_id,
    inverse_of: false
  belongs_to :alternate_game,
    class_name: "GamedbGame",
    foreign_key: :alt_game_id,
    inverse_of: false
end
