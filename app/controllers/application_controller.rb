class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Permit role_ids parameter to user model
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_resource

  # Redirect user to Dashboard after sign in
  def after_sign_in_path_for(resource)
    home_passthrough_path
  end

  # Redirect user to index page after sign out
  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  
  def has_role?(current_user, role)
    return !!current_user.roles.find_by_name(role.to_s.camelize)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def check_chama_service_validity
    #check whether chama has renewed service
    @service_fee = ServiceFee.where(:chama_id => current_user.chama.id).last
    
    # Check if user has renewed service
    if @service_fee.service_status != "OK"
      # Service not renewed or service status is not OK
      redirect_to home_service_suspended_path
      return
    end
  end

  # Private methods
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :username, :email, :password, :password_confirmation, :phone_number, :national_id_number,:role_ids) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  def layout_by_resource
    if devise_controller? and !user_signed_in?
      'landing'
    else
      'application'
    end
  end

end
