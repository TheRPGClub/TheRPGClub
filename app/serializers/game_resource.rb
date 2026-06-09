# frozen_string_literal: true

# Serializes a GamedbGame for games#index / games#show: the consumer-audited
# GameFields shape (columns + image URLs) plus the `gotm_won` / `nr_gotm_won`
# flags.
#
# `gotm_won` / `nr_gotm_won` are SQL aliases selected by the `without_images`
# scope, not real columns, so they are declared explicitly here. They are only
# present on records loaded through `GamedbGame.without_images`; every game
# endpoint uses that scope.
class GameResource
  include BaseResource
  include GameFields

  attributes :gotm_won, :nr_gotm_won
end
