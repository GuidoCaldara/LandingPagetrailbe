class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if resource.username
       root_path
    else
       edit_user_profile_path
    end
end



  protected

  def profile_to_check
    params[:controller] == "runs" || params[:controller] == "users"
  end

  def check_profile
    if (user_signed_in? && current_user.username.nil? )
     flash[:alert] = "E'necessario completare il tuo profilo prima di poter utilizzare TrailBe"
     return redirect_to(edit_user_profile_path)
  end
end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username avatar location])
  end
end
