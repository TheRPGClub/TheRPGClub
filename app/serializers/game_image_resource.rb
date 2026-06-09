# frozen_string_literal: true

# Serializes a GamedbGameImage: all columns plus the derived public `url`
# (mirrors GamedbGameImage#as_json).
class GameImageResource
  include BaseResource

  columns_of GamedbGameImage
  attributes :url
end
