# frozen_string_literal: true

module Api
  module V1
    class ThemesController < ApplicationController
      include TaxonomyEndpoints

      serves_taxonomy GamedbTheme, resource: ThemeResource
    end
  end
end
