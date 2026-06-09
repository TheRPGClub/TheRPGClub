# frozen_string_literal: true

# Serializes a GamedbFranchise (all columns).
class FranchiseResource
  include BaseResource

  columns_of GamedbFranchise
end
