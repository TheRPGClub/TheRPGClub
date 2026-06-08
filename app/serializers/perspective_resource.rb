# frozen_string_literal: true

# Serializes a GamedbPerspective (all columns).
class PerspectiveResource
  include BaseResource

  columns_of GamedbPerspective
end
