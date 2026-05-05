# frozen_string_literal: true

class GamedbGameGenre < ApplicationRecord
  self.table_name = "gamedb_game_genres"
  self.primary_key = %i[game_id genre_id]

  belongs_to :game,
    class_name: "GamedbGame",
    foreign_key: :game_id,
    inverse_of: :game_genres
  belongs_to :genre,
    class_name: "GamedbGenre",
    foreign_key: :genre_id,
    inverse_of: :game_genres
end
