class RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(_resource)
    edit_user_profile_path
  end
end
