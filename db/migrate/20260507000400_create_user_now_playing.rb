# frozen_string_literal: true

class CreateUserNowPlaying < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:user_now_playing)

    create_table :user_now_playing, primary_key: :entry_id do |table|
      table.string :user_id, limit: 30, null: false
      table.bigint :gamedb_game_id
      table.bigint :platform_id
      table.column :added_at, "timestamp(6) with time zone", default: -> { "statement_timestamp()" }, null: false
      table.string :note, limit: 500
      table.bigint :sort_order
      table.column :note_updated_at, "timestamp(6) with time zone"
    end

    add_index :user_now_playing, %i[user_id gamedb_game_id],
              unique: true,
              name: "uq_user_now_playing_gamedb"
    add_index :user_now_playing, :user_id, name: "ix_user_now_playing_user"
    add_index :user_now_playing, %i[user_id sort_order], name: "ix_user_now_playing_sort"
    add_index :user_now_playing, :platform_id, name: "ix_user_now_playing_platform"

    add_foreign_key :user_now_playing,
                    :gamedb_games,
                    column: :gamedb_game_id,
                    primary_key: :game_id,
                    name: "fk_user_now_playing_gamedb"
    add_foreign_key :user_now_playing,
                    :gamedb_platforms,
                    column: :platform_id,
                    primary_key: :platform_id,
                    name: "fk_user_now_playing_platform"
  end

  def down
    drop_table :user_now_playing, if_exists: true
  end
end
