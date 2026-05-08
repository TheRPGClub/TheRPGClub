# frozen_string_literal: true

class CreateThreadsAndThreadGameLinks < ActiveRecord::Migration[8.1]
  def up
    create_threads_table unless table_exists?(:threads)
    create_thread_game_links_table unless table_exists?(:thread_game_links)
  end

  def down
    drop_table :thread_game_links, if_exists: true
    drop_table :threads, if_exists: true
  end

  private

  def create_threads_table
    create_table :threads, id: false do |table|
      table.string :thread_id, limit: 30, null: false
      table.string :forum_channel_id, limit: 30, null: false
      table.string :thread_name, limit: 200, null: false
      table.bigint :gamedb_game_id
      table.string :is_archived, limit: 1, default: "N", null: false
      table.column :created_at, "timestamp(6) with time zone", default: -> { "statement_timestamp()" }, null: false
      table.column :last_seen_at, "timestamp(6) with time zone"
      table.string :skip_linking, limit: 1, default: "N", null: false
    end

    execute "ALTER TABLE threads ADD PRIMARY KEY (thread_id)"
    add_index :threads, :gamedb_game_id, name: "ix_threads_gamedb"
    add_index :threads, :forum_channel_id, name: "ix_threads_forum"
    add_check_constraint :threads, "is_archived IN ('Y', 'N')", name: "ck_threads_is_archived"
    add_check_constraint :threads, "skip_linking IN ('Y', 'N')", name: "ck_threads_skip_linking"
    add_foreign_key :threads,
                    :gamedb_games,
                    column: :gamedb_game_id,
                    primary_key: :game_id,
                    name: "fk_threads_gamedb_game"
  end

  def create_thread_game_links_table
    create_table :thread_game_links, id: false do |table|
      table.string :thread_id, limit: 50, null: false
      table.bigint :gamedb_game_id, null: false
      table.column :linked_at, "timestamp(6) with time zone", default: -> { "statement_timestamp()" }, null: false
    end

    execute "ALTER TABLE thread_game_links ADD PRIMARY KEY (thread_id, gamedb_game_id)"
    add_index :thread_game_links, :gamedb_game_id, name: "ix_thread_game_links_game"
  end
end
