# frozen_string_literal: true

# Serializes a SocialPlatform (all columns). Also embedded by UserSocialResource.
class SocialPlatformResource
  include BaseResource

  columns_of SocialPlatform
end
