# frozen_string_literal: true

class AllowNullGamedbGameIdOnUserNowPlaying < ActiveRecord::Migration[8.1]
  def up
    return unless table_exists?(:user_now_playing)

    change_column_null :user_now_playing, :gamedb_game_id, true
  end

  def down
    return unless table_exists?(:user_now_playing)

    change_column_null :user_now_playing, :gamedb_game_id, false
  end
end
