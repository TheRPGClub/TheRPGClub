# frozen_string_literal: true

# A UserGameReview with its embedded user, for the game-scoped reviews list:
# the consumer-audited ReviewFields columns plus the `user` summary (without
# binary image blobs).
class ReviewUserEntryResource
  include BaseResource
  include ReviewFields

  one :user, resource: UserSummaryResource
end
