# frozen_string_literal: true

# The full user-profile payload served by users#show. Replaces the hand-built
# `user.as_json.merge(...)`: every non-binary column plus `membership`, the
# embedded `socials`, the four embedded preview lists and the `counts` summary.
#
# The previews and counts are not associations on the user — the controller
# pre-fetches limited, preloaded, ordered slices (and the count tallies) and
# hands them in via Alba `params`, so the resource serializes those exact
# scopes rather than re-querying. Each preview reuses the #32 entry resource so
# the embedded entries carry their joined `game`/`platform` (the reviews
# preview embeds `one :game`), unblocking the frontend to drop its per-list
# fan-out (TheRPGClub-www#11).
class UserResource
  include BaseResource

  columns_of RpgClubUser, except: RpgClubUser::BINARY_COLUMNS
  attributes :membership
  many :socials, resource: UserSocialResource

  many :now_playing, resource: NowPlayingEntryResource, source: ->(params) { params[:now_playing] || [] }
  many :favorites,   resource: FavoriteEntryResource,   source: ->(params) { params[:favorites] || [] }
  many :reviews,     resource: ReviewEntryResource,     source: ->(params) { params[:reviews] || [] }
  many :completions, resource: CompletionEntryResource, source: ->(params) { params[:completions] || [] }

  attribute :counts do
    params[:counts] || {}
  end
end
