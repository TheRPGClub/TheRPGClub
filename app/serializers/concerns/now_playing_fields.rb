# frozen_string_literal: true

# The consumer-audited now-playing allowlist (#36), shared by the game-embedded
# (NowPlayingEntryResource) and user-embedded (NowPlayingUserEntryResource)
# variants of the same entry.
#
# The entry PK (`entry_id`), `user_id` (game-scoped lists dedup players by it),
# `gamedb_game_id`, `platform_id` and `note` are read; `added_at`, `sort_order`
# and `note_updated_at` are dropped from output.
module NowPlayingFields
  extend ActiveSupport::Concern

  included do
    attributes :entry_id, :user_id, :gamedb_game_id, :platform_id, :note
  end
end
