# frozen_string_literal: true

class UserNowPlaying < ApplicationRecord
  self.table_name = "user_now_playing"
  self.primary_key = "entry_id"

  belongs_to :user,
    class_name: "RpgClubUser",
    foreign_key: :user_id,
    primary_key: :user_id,
    optional: true
  belongs_to :game,
    class_name: "GamedbGame",
    foreign_key: :gamedb_game_id,
    optional: true,
    inverse_of: :user_now_playing_entries
  belongs_to :platform,
    class_name: "GamedbPlatform",
    foreign_key: :platform_id,
    optional: true,
    inverse_of: :user_now_playing_entries
end
