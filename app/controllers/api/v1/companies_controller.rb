# frozen_string_literal: true

module Api
  module V1
    class CompaniesController < ApplicationController
      include TaxonomyEndpoints

      serves_taxonomy GamedbCompany, resource: CompanyResource
    end
  end
end
