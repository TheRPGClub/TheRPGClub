# frozen_string_literal: true

module Auth
  class Principal
    attr_reader :kind, :id, :discord_id, :username, :global_name, :avatar, :email

    def initialize(kind:, id:, discord_id: nil, username: nil, global_name: nil, avatar: nil, email: nil)
      @kind = kind.to_s
      @id = id.to_s
      @discord_id = discord_id&.to_s
      @username = username
      @global_name = global_name
      @avatar = avatar
      @email = email
    end

    def self.service
      new(kind: "service", id: "discord_bot")
    end

    def self.discord_user(user, discord_payload = {})
      new(
        kind: "discord_user",
        id: user.user_id,
        discord_id: user.user_id,
        username: discord_payload["username"] || user.username,
        global_name: discord_payload["global_name"] || user.global_name,
        avatar: discord_payload["avatar"],
        email: discord_payload["email"]
      )
    end

    def self.from_session(payload)
      return if payload.blank?

      new(
        kind: payload["kind"],
        id: payload["id"],
        discord_id: payload["discord_id"],
        username: payload["username"],
        global_name: payload["global_name"],
        avatar: payload["avatar"],
        email: payload["email"]
      )
    end

    def to_session
      {
        "kind" => kind,
        "id" => id,
        "discord_id" => discord_id,
        "username" => username,
        "global_name" => global_name,
        "avatar" => avatar,
        "email" => email
      }
    end

    def service?
      kind == "service"
    end

    def discord_user?
      kind == "discord_user"
    end

    def as_json(*)
      to_session.except("email").merge("service" => service?)
    end
  end
end
