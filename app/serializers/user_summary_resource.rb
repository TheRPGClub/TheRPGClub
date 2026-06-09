# frozen_string_literal: true

# The reusable embedded-user shape: every RpgClubUser column except the binary
# image blobs. Matches `user.as_json(except: RpgClubUser::BINARY_COLUMNS)` and
# the `RpgClubUser.without_images` scope (which selects exactly these columns).
class UserSummaryResource
  include BaseResource

  columns_of RpgClubUser, except: RpgClubUser::BINARY_COLUMNS
end
