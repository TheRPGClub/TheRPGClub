# frozen_string_literal: true

class CreateUserSessionTokens < ActiveRecord::Migration[8.1]
  def change
    create_table :user_session_tokens do |t|
      t.string :token, null: false
      t.string :user_id, null: false
      t.datetime :expires_at, null: false
      t.timestamps
    end

    add_index :user_session_tokens, :token, unique: true
    add_index :user_session_tokens, :user_id
  end
end
