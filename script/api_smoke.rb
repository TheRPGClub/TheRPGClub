# frozen_string_literal: true

token = ENV.fetch("RPGCLUB_BOT_API_TOKEN", "dev-token")
headers = { "Authorization" => "Bearer #{token}" }
session = ActionDispatch::Integration::Session.new(Rails.application)
session.host! "localhost"

session.get("/api/v1/health")
puts [ "health", session.response.status, session.response.body ].join(" | ")

session.get("/api/v1/games?q=trails", headers: headers)
puts [ "games", session.response.status, session.response.parsed_body.fetch("data").length ].join(" | ")

session.get("/api/v1/users", headers: headers)
puts [ "users", session.response.status, session.response.parsed_body.fetch("data").length ].join(" | ")
user_id = session.response.parsed_body.fetch("data").first.fetch("user_id")

session.get("/api/v1/users/#{user_id}/collections", headers: headers)
puts [ "collections", session.response.status, session.response.parsed_body.fetch("data").length ].join(" | ")
