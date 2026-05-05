# frozen_string_literal: true

class CreateGamedbReleaseAnnouncements < ActiveRecord::Migration[8.1]
  def up
    return if table_exists?(:gamedb_release_announcements)

    create_table :gamedb_release_announcements, id: false do |table|
      table.bigint :release_id, null: false
      table.datetime :announce_at, precision: 6, null: false
      table.datetime :sent_at, precision: 6
      table.datetime :skipped_at, precision: 6
      table.string :skip_reason, limit: 80
      table.datetime :created_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
      table.datetime :updated_at, precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    end

    execute "ALTER TABLE gamedb_release_announcements ADD PRIMARY KEY (release_id)"
    add_index :gamedb_release_announcements, %i[sent_at skipped_at announce_at], name: "idx_gamedb_release_announce_pending"
  end

  def down
    drop_table :gamedb_release_announcements, if_exists: true
  end
end
