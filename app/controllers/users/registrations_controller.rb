# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]

  # POST /resource
  def create
    super do |resource|
      if resource.persisted?
        return redirect_to root_path,
                           notice: "Account creation successful. Log in to continue"
      end
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :fullname, :username ])
  end
end
