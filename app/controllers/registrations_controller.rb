class RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(_resource)
    edit_user_profile_path
  end

  def after_sign_in_path_for(resource)
    if resource.username
       root_path
    else
       edit_user_profile_path
    end
end

end
