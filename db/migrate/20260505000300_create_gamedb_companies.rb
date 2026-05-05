# frozen_string_literal: true

class CreateGamedbCompanies < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_companies)

    create_table :gamedb_companies, primary_key: :company_id do |table|
      table.string :name, null: false
      table.bigint :igdb_company_id
    end

    add_index :gamedb_companies, :igdb_company_id, unique: true
  end

  def down
    drop_table :gamedb_companies, if_exists: true
  end
end
