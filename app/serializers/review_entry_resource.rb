# frozen_string_literal: true

# A UserGameReview with its embedded game, for the reviews preview on a user's
# profile: the consumer-audited ReviewFields columns plus `game`.
class ReviewEntryResource
  include BaseResource
  include ReviewFields

  one :game, resource: GameSummaryResource
end
