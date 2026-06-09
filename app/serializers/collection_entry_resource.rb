# frozen_string_literal: true

# Serializes a UserGameCollection entry (all columns).
class CollectionEntryResource
  include BaseResource

  columns_of UserGameCollection
end
