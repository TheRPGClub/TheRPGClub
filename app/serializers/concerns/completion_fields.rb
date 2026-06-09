# frozen_string_literal: true

# The consumer-audited completion allowlist (#36), shared by the game-embedded
# (CompletionEntryResource) and user-embedded (CompletionUserEntryResource)
# variants of the same entry.
#
# The entry PK (`completion_id`), `user_id`, `gamedb_game_id`, `platform_id`,
# `note` and the completion data (`completion_type`, `completed_at`,
# `final_playtime_hrs`) are read; `created_at` is dropped from output (the table
# has no `updated_at`).
module CompletionFields
  extend ActiveSupport::Concern

  included do
    attributes :completion_id, :user_id, :gamedb_game_id, :platform_id, :note,
               :completion_type, :completed_at, :final_playtime_hrs
  end
end
