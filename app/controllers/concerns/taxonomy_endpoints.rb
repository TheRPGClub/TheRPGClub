# frozen_string_literal: true

# Standardized `index`/`show` actions for the IGDB-curated taxonomy master
# tables (genres, themes, perspectives, modes, franchises, companies).
#
# Each of these models is a controlled vocabulary with a `name` column and a
# custom primary key, and the endpoints they back are identical apart from the
# model and its serializer. A controller `include TaxonomyEndpoints` and calls
# `serves_taxonomy` instead of repeating six near-identical controllers.
#
#   class Api::V1::GenresController < ApplicationController
#     include TaxonomyEndpoints
#     serves_taxonomy GamedbGenre, resource: GenreResource
#   end
#
# `index` lists every record ordered by `name`, with an optional `?q`
# case-insensitive ILIKE-on-`name` filter, paginated via `render_collection`
# (ApplicationController). `show` returns a single record by primary key and
# 404s when it is missing (handled by the global RecordNotFound rescue).
module TaxonomyEndpoints
  extend ActiveSupport::Concern

  class_methods do
    # @param model [Class] an ActiveRecord master-table model with a `name` column
    # @param resource [Class] the Alba resource used to serialize it
    def serves_taxonomy(model, resource:)
      define_method(:index) do
        scope = model.all
        scope = scope.where("name ILIKE ?", "%#{taxonomy_query}%") if params[:q].present?

        render_collection(scope, resource: resource, default_order: { name: :asc })
      end

      define_method(:show) do
        render json: { data: resource.new(model.find(params[:id])).serializable_hash }
      end
    end
  end

  private

  def taxonomy_query
    ActiveRecord::Base.sanitize_sql_like(params[:q].to_s.strip)
  end
end
