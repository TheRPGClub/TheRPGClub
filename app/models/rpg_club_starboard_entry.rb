# frozen_string_literal: true

class RpgClubStarboardEntry < ApplicationRecord
  self.table_name = "rpg_club_starboard"
  self.primary_key = "message_id"
end
