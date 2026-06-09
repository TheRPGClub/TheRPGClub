# frozen_string_literal: true

# The reusable embedded-game shape. The consumer-audited column set + image
# URLs live in GameFields (#36); unlike GameResource this omits the
# `gotm_won`/`nr_gotm_won` aliases (only present on `without_images` records).
class GameSummaryResource
  include BaseResource
  include GameFields
end
