# frozen_string_literal: true

# A UserGameCompletion with its embedded user, for the game-scoped completions
# list: the consumer-audited CompletionFields columns plus the `user` summary
# (without binary image blobs).
class CompletionUserEntryResource
  include BaseResource
  include CompletionFields

  one :user, resource: UserSummaryResource
end
