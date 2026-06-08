# frozen_string_literal: true

# Serializes a GamedbGenre (all columns).
class GenreResource
  include BaseResource

  columns_of GamedbGenre
end
