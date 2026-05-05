# frozen_string_literal: true

class BotVotingInfo < ApplicationRecord
  self.table_name = "bot_voting_info"
  self.primary_key = "round_number"
end
