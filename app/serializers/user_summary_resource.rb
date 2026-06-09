# frozen_string_literal: true

# The reusable embedded-user shape, also served directly by users#index (the
# members list). The consumer-audited column set lives in UserFields (#36), so
# this and the full UserResource profile payload never drift apart.
class UserSummaryResource
  include BaseResource
  include UserFields
end
