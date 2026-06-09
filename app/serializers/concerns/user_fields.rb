# frozen_string_literal: true

# The consumer-audited user column allowlist (#36), shared by the embedded
# user shape (UserSummaryResource) and the full profile payload (UserResource)
# so the two never drift apart.
#
# The web frontend reads exactly these columns: the identity/name fields,
# `is_bot` and `server_left_at` (the members list filters out bots and departed
# members), and the three public role flags the members list buckets on.
# `role_member`/`role_newcomer` are intentionally omitted — they still back the
# server-side `membership` calc via the model, but no consumer reads them off
# the wire. The avatar is fetched from `/users/:id/avatar`, not a column, so
# image/bookkeeping columns (`discord_avatar`, `*_at` timestamps,
# `message_count`, …) are dropped.
module UserFields
  extend ActiveSupport::Concern

  included do
    attributes :user_id, :username, :global_name, :is_bot,
               :role_admin, :role_moderator, :role_regular,
               :server_left_at
  end
end
