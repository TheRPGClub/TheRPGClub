# frozen_string_literal: true

class GamedbGameCompany < ApplicationRecord
  self.table_name = "gamedb_game_companies"
  self.primary_key = %i[game_id company_id role]

  belongs_to :game,
    class_name: "GamedbGame",
    foreign_key: :game_id,
    inverse_of: :game_companies
  belongs_to :company,
    class_name: "GamedbCompany",
    foreign_key: :company_id,
    inverse_of: :game_companies
end
