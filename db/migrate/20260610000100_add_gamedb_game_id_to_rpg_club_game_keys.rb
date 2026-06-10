# frozen_string_literal: true

# Optionally links a giveaway key to a GamedbGame so the API can embed the
# game's cover/art and metadata (#42), the way favorites/backlog do. The column
# is nullable on purpose: the bot inserts keys with only the free-text
# `game_title` (it never sets this id), and not every donated game exists in
# `gamedb_games` — those keys keep `game_title` and a null link. `on_delete:
# :nullify` drops the link (not the key) if a referenced game is removed.
#
# The backfill links existing keys whose `game_title` exactly matches a
# GamedbGame title. Today that resolves three of the nine live keys (Core
# Keeper → 4824, Persona 5 Strikers → 2031, Symphony of War: The Nephilim Saga →
# 1554); the other six games aren't in `gamedb_games`, so those keys stay
# unlinked until the games are imported. Idempotent (only touches null links).
class AddGamedbGameIdToRpgClubGameKeys < ActiveRecord::Migration[8.1]
  def up
    unless column_exists?(:rpg_club_game_keys, :gamedb_game_id)
      add_column :rpg_club_game_keys, :gamedb_game_id, :bigint
    end

    add_index :rpg_club_game_keys, :gamedb_game_id,
              name: "ix_game_keys_game",
              if_not_exists: true

    unless foreign_key_exists?(:rpg_club_game_keys, :gamedb_games, column: :gamedb_game_id)
      add_foreign_key :rpg_club_game_keys,
                      :gamedb_games,
                      column: :gamedb_game_id,
                      primary_key: :game_id,
                      on_delete: :nullify,
                      name: "fk_rpg_club_game_keys_gamedb"
    end

    execute(<<~SQL.squish)
      UPDATE rpg_club_game_keys AS gk
      SET gamedb_game_id = sub.game_id
      FROM (SELECT title, MIN(game_id) AS game_id FROM gamedb_games GROUP BY title) AS sub
      WHERE gk.gamedb_game_id IS NULL AND gk.game_title = sub.title
    SQL
  end

  def down
    remove_foreign_key :rpg_club_game_keys, column: :gamedb_game_id, if_exists: true
    remove_index :rpg_club_game_keys, name: "ix_game_keys_game", if_exists: true
    remove_column :rpg_club_game_keys, :gamedb_game_id, if_exists: true
  end
end
