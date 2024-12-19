# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  rate_limit to: 3, within: 30.seconds, with: -> {
               redirect_to root_path,
                           alert: "Too many failed login attempts!"
             }, only: :create
end
