# frozen_string_literal: true

# Serializes a GamedbGameModeDef (all columns). Backs GamedbGame#modes.
class ModeResource
  include BaseResource

  columns_of GamedbGameModeDef
end
