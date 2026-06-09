# frozen_string_literal: true

# A UserGameBacklog with its embedded game and platform. `platform` renders
# `null` when the entry has no platform.
#
# Consumer-audited allowlist (#36): the entry PK (`entry_id`), `user_id`,
# `gamedb_game_id`, `platform_id` and `note` are read; `sort_order`,
# `created_at` and `updated_at` are dropped from output.
class BacklogEntryResource
  include BaseResource

  attributes :entry_id, :user_id, :gamedb_game_id, :platform_id, :note
  one :game, resource: GameSummaryResource
  one :platform, resource: PlatformResource
end
