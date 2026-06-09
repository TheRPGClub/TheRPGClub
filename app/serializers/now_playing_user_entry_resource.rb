# frozen_string_literal: true

# A UserNowPlaying entry with its embedded user, for the game-scoped now-playing
# list: the consumer-audited NowPlayingFields columns plus the `user` summary
# (without binary image blobs).
class NowPlayingUserEntryResource
  include BaseResource
  include NowPlayingFields

  one :user, resource: UserSummaryResource
end
