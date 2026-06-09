# frozen_string_literal: true

# Serializes a UserSocial: all columns (including `id` and `url`, which the
# frontend reads as `social.id` / `social.url`) plus the embedded social
# platform. Expects the `social_platform` association to be loaded.
class UserSocialResource
  include BaseResource

  columns_of UserSocial
  one :social_platform, resource: SocialPlatformResource
end
