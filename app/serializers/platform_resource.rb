# frozen_string_literal: true

# Serializes a GamedbPlatform.
#
# Consumer-audited allowlist (#36): the web frontend reads `platform_id` and
# `platform_name`; `platform_code` is kept because the Discord bot may key on
# platform codes (its source is not auditable — see issue #36). The IGDB sync
# bookkeeping columns (`igdb_platform_id`, `platform_abbreviation`,
# `platform_slug`, `platform_checksum`, `igdb_updated_at`) are internal and
# read by no consumer, so they are dropped from output.
class PlatformResource
  include BaseResource

  attributes :platform_id, :platform_code, :platform_name
end
