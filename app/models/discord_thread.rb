# frozen_string_literal: true

# A Discord forum thread the bot tracks (#45). Mapped to one or more games
# through `thread_game_links` (see ThreadGameLink); the legacy `gamedb_game_id`
# column carries the bot's single "primary" game for the thread (the MIN of its
# links), kept for the older 1:1 lookups.
#
# Named DiscordThread, not Thread, because `Thread` is a Ruby core class —
# reopening it as an ActiveRecord model raises "superclass mismatch". The table
# is still `threads`. The bot owns all writes, so this model is read-only here.
class DiscordThread < ApplicationRecord
  self.table_name = "threads"
  self.primary_key = "thread_id"

  has_many :thread_game_links,
    class_name: "ThreadGameLink",
    foreign_key: :thread_id,
    primary_key: :thread_id,
    inverse_of: :thread,
    dependent: nil

  has_many :games,
    through: :thread_game_links,
    source: :game

  belongs_to :game,
    class_name: "GamedbGame",
    foreign_key: :gamedb_game_id,
    primary_key: :game_id,
    optional: true,
    inverse_of: nil
end
