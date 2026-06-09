# frozen_string_literal: true

# A UserNowPlaying entry with its embedded game and platform. `platform`
# renders `null` when the entry has no platform. The consumer-audited column
# set lives in NowPlayingFields (#36).
class NowPlayingEntryResource
  include BaseResource
  include NowPlayingFields

  one :game, resource: GameSummaryResource
  one :platform, resource: PlatformResource
end
