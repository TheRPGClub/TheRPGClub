# frozen_string_literal: true

class GamedbGameFranchise < ApplicationRecord
  self.table_name = "gamedb_game_franchises"
  self.primary_key = %i[game_id franchise_id]

  belongs_to :game,
    class_name: "GamedbGame",
    foreign_key: :game_id,
    inverse_of: :game_franchises
  belongs_to :franchise,
    class_name: "GamedbFranchise",
    foreign_key: :franchise_id,
    inverse_of: :game_franchises
end
