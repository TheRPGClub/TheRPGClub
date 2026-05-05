# frozen_string_literal: true

class GamedbCollection < ApplicationRecord
  self.table_name = "gamedb_collections"
  self.primary_key = "collection_id"

  has_many :games,
    class_name: "GamedbGame",
    foreign_key: :collection_id,
    dependent: nil,
    inverse_of: :collection

  validates :name, presence: true
end
