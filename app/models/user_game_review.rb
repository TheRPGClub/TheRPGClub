# frozen_string_literal: true

class UserGameReview < ApplicationRecord
  self.table_name = "user_game_reviews"
  self.primary_key = "review_id"

  belongs_to :user,
    class_name: "RpgClubUser",
    foreign_key: :user_id,
    primary_key: :user_id,
    inverse_of: :reviews
  belongs_to :game,
    class_name: "GamedbGame",
    foreign_key: :gamedb_game_id,
    inverse_of: :reviews

  validates :user_id, :gamedb_game_id, presence: true
  validates :rating,
            presence: true,
            numericality: { only_integer: true, in: 0..100 }
  validates :user_id, uniqueness: { scope: :gamedb_game_id }
end
