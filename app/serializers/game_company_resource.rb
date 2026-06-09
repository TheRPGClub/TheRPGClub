# frozen_string_literal: true

# A GamedbGameCompany join row flattened to its company's columns plus the
# join's `role`, for the `companies` slice of games#relations. Replaces the
# ad-hoc `companies_for` helper (`company.as_json.merge("role" => role)`).
#
# The object is the join row, so each company column is delegated to the
# loaded `company` association; declaring them off `GamedbCompany.column_names`
# keeps the shape tracking the companies table automatically. Expects `company`
# to be loaded.
class GameCompanyResource
  include BaseResource

  GamedbCompany.column_names.each do |column|
    attribute(column) { |game_company| game_company.company.public_send(column) }
  end

  attribute(:role) { |game_company| game_company.role }
end
