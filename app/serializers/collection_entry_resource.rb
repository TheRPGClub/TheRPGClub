# frozen_string_literal: true

# Serializes a UserGameCollection entry.
#
# Consumer-audited allowlist (#36): the entry PK (`entry_id`), `user_id`,
# `gamedb_game_id`, `platform_id`, `ownership_type` and `note` are read;
# `is_shared` (write-only input), `created_at` and `updated_at` are dropped
# from output.
class CollectionEntryResource
  include BaseResource

  attributes :entry_id, :user_id, :gamedb_game_id, :platform_id, :ownership_type, :note
end
