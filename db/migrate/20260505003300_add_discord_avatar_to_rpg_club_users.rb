# frozen_string_literal: true

class AddDiscordAvatarToRpgClubUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :rpg_club_users, :discord_avatar, :string, limit: 128
  end
end
