# frozen_string_literal: true

class AddLogoKindToGamedbGameImages < ActiveRecord::Migration[8.1]
  def change
    remove_check_constraint :gamedb_game_images, name: "ck_gamedb_game_images_kind", if_exists: true
    add_check_constraint :gamedb_game_images, "kind IN ('cover', 'artwork', 'logo')", name: "ck_gamedb_game_images_kind"
  end
end
