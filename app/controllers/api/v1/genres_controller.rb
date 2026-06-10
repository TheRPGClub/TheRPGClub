# frozen_string_literal: true

module Api
  module V1
    class GenresController < ApplicationController
      include TaxonomyEndpoints

      serves_taxonomy GamedbGenre, resource: GenreResource
    end
  end
end
