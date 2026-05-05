# frozen_string_literal: true

class CreateGamedbGameCompanies < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_game_companies)

    create_table :gamedb_game_companies, id: false do |table|
      table.bigint :game_id, null: false
      table.bigint :company_id, null: false
      table.string :role, limit: 30, null: false
    end

    execute "ALTER TABLE gamedb_game_companies ADD PRIMARY KEY (game_id, company_id, role)"
  end

  def down
    drop_table :gamedb_game_companies, if_exists: true
  end
end
