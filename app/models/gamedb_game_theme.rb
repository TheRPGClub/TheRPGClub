# frozen_string_literal: true

class GamedbGameTheme < ApplicationRecord
  self.table_name = "gamedb_game_themes"
  self.primary_key = %i[game_id theme_id]

  belongs_to :game,
    class_name: "GamedbGame",
    foreign_key: :game_id,
    inverse_of: :game_themes
  belongs_to :theme,
    class_name: "GamedbTheme",
    foreign_key: :theme_id,
    inverse_of: :game_themes
end
