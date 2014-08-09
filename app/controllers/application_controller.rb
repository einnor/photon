class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Redirect user to Dashboard after sign in
  def after_sign_in_path_for(resource)
    home_passthrough_path
  end

  # Redirect user to index page after sign out
  def after_sign_out_path_for(resource)
    home_index_path
  end

  
  def has_role?(current_user, role)
    return !!current_user.roles.find_by_name(role.to_s.camelize)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
