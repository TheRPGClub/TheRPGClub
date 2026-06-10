# frozen_string_literal: true

# A presence prompt the bot sent a user after detecting (via Discord rich
# presence) that they were playing a game (bot parity, #48). Read-only over the
# API: the bot's presence-detection loop owns creation (`createPrompt`) and
# resolution (`markResolved`). The user-settable side is PresencePromptOpt.
class PresencePrompt < ApplicationRecord
  self.table_name = "rpg_club_presence_prompt_history"
  self.primary_key = "prompt_id"

  # Lifecycle states a prompt moves through, mirroring the bot.
  STATUSES = %w[PENDING ACCEPTED DECLINED OPT_OUT_GAME OPT_OUT_ALL].freeze

  belongs_to :user,
    class_name: "RpgClubUser",
    foreign_key: :user_id,
    primary_key: :user_id,
    optional: true,
    inverse_of: :presence_prompts
end
