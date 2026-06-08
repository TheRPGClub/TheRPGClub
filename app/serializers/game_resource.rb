# frozen_string_literal: true

# Serializes a GamedbGame, matching the current games#index / games#show wire
# shape (GamedbGame#as_json):
#   - every column except `total_rating`
#   - the derived image URLs (`cover_url` / `art_url` / `logo_url`)
#   - the `gotm_won` / `nr_gotm_won` flags
#
# `gotm_won` / `nr_gotm_won` are SQL aliases selected by the `without_images`
# scope, not real columns, so `columns_of` cannot pick them up — they are
# re-declared here. They are only present on records loaded through
# `GamedbGame.without_images`; every game endpoint uses that scope.
class GameResource
  include BaseResource

  columns_of GamedbGame, except: %w[total_rating]
  attributes :gotm_won, :nr_gotm_won
  attributes :cover_url, :art_url, :logo_url
end
