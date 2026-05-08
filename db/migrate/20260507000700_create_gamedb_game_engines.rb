# frozen_string_literal: true

class CreateGamedbGameEngines < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_game_engines)

    create_table :gamedb_game_engines, id: false do |table|
      table.bigint :game_id, null: false
      table.bigint :engine_id, null: false
    end

    execute "ALTER TABLE gamedb_game_engines ADD PRIMARY KEY (game_id, engine_id)"
    add_index :gamedb_game_engines, :game_id
    add_index :gamedb_game_engines, :engine_id
    add_foreign_key :gamedb_game_engines,
                    :gamedb_games,
                    column: :game_id,
                    primary_key: :game_id,
                    on_delete: :cascade,
                    name: "fk_ge_game"
    add_foreign_key :gamedb_game_engines,
                    :gamedb_engines,
                    column: :engine_id,
                    primary_key: :engine_id,
                    name: "fk_ge_engine"
  end

  def down
    drop_table :gamedb_game_engines, if_exists: true
  end
end
