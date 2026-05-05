# frozen_string_literal: true

class RpgClubPublicReminder < ApplicationRecord
  self.table_name = "rpg_club_public_reminders"
  self.primary_key = "reminder_id"
end
