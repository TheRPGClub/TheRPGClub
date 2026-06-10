# frozen_string_literal: true

# Serializes a PresencePrompt history row (all columns, read-only) — #48.
class PresencePromptResource
  include BaseResource

  columns_of PresencePrompt
end
