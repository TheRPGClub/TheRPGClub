# frozen_string_literal: true

class GotmEntry < ApplicationRecord
  self.table_name = "gotm_entries"
  self.primary_key = "gotm_id"

  belongs_to :game,
    class_name: "GamedbGame",
    foreign_key: :gamedb_game_id,
    optional: true,
    inverse_of: :gotm_entries

  def as_json(options = nil)
    payload = super(options)
    payload["game"] = game&.as_json if association(:game).loaded?
    payload
  end
end
