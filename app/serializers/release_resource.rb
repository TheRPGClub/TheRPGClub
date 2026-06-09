# frozen_string_literal: true

# Serializes a GamedbRelease: all columns plus the platform/region fields
# flattened onto the release (mirrors GamesController#release_json). Expects the
# `platform` and `region` associations to be loaded.
class ReleaseResource
  include BaseResource

  columns_of GamedbRelease
  attribute(:platform_code) { |release| release.platform.platform_code }
  attribute(:platform_name) { |release| release.platform.platform_name }
  attribute(:region_code) { |release| release.region.region_code }
  attribute(:region_name) { |release| release.region.region_name }
end
