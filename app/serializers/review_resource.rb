# frozen_string_literal: true

# The reusable review shape. The consumer-audited column set lives in
# ReviewFields (#36), shared with the embedded review variants.
class ReviewResource
  include BaseResource
  include ReviewFields
end
