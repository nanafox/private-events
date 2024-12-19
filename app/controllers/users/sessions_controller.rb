# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  if Rails.env.local?
    RATE_LIMIT_STORE = ActiveSupport::Cache::MemoryStore.new
  else
    RATE_LIMIT_STORE = ActiveSupport::Cache::RedisCacheStore.new(url: ENV["REDIS_URL"])
  end

  rate_limit to: 3, within: 30.seconds, with: -> {
               redirect_to root_path,
                           alert: "Too many failed login attempts!"
             }, only: :create, store: RATE_LIMIT_STORE
end
