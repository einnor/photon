class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Permit role_ids parameter to user model
  # before_action :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_resource

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

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :phone_number, :national_id_number,:role_ids) }
  end

  def layout_by_resource
    if devise_controller? and !user_signed_in?
      'landing'
    else
      'application'
    end
  end
end
