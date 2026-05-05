# frozen_string_literal: true

require "digest"
require "warden"

Warden::Strategies.add(:api_token) do
  def valid?
    authorization_header.present? && expected_token.present?
  end

  def authenticate!
    token = authorization_header.to_s.delete_prefix("Bearer ").strip

    if secure_token_match?(token, expected_token)
      success!(Auth::Principal.service)
    else
      fail!("Invalid API token")
    end
  end

  private

  def authorization_header
    request.get_header("HTTP_AUTHORIZATION")
  end

  def expected_token
    ENV["RPGCLUB_BOT_API_TOKEN"]
  end

  def secure_token_match?(given, expected)
    return false if given.blank? || expected.blank?

    ActiveSupport::SecurityUtils.secure_compare(
      Digest::SHA256.hexdigest(given),
      Digest::SHA256.hexdigest(expected)
    )
  end
end

Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.failure_app = lambda do |_env|
    [
      401,
      { "Content-Type" => "application/json" },
      [ { error: "unauthorized" }.to_json ]
    ]
  end

  manager.serialize_into_session do |principal|
    principal.to_session if principal.respond_to?(:discord_user?) && principal.discord_user?
  end

  manager.serialize_from_session do |payload|
    Auth::Principal.from_session(payload)
  end
end
