# frozen_string_literal: true

class GamedbCompany < ApplicationRecord
  self.table_name = "gamedb_companies"
  self.primary_key = "company_id"

  has_many :game_companies,
    class_name: "GamedbGameCompany",
    foreign_key: :company_id,
    dependent: nil,
    inverse_of: :company
  has_many :games,
    through: :game_companies,
    source: :game

  validates :name, presence: true
end
