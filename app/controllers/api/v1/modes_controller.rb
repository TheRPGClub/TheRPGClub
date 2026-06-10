# frozen_string_literal: true

module Api
  module V1
    class ModesController < ApplicationController
      include TaxonomyEndpoints

      serves_taxonomy GamedbGameModeDef, resource: ModeResource
    end
  end
end
