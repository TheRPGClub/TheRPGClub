# frozen_string_literal: true

module Api
  module V1
    class PerspectivesController < ApplicationController
      include TaxonomyEndpoints

      serves_taxonomy GamedbPerspective, resource: PerspectiveResource
    end
  end
end
