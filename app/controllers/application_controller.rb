class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Redirect user to Dashboard after sign in
  def after_sign_in_path_for(resource)
    home_dashboard_path
  end

  # Redirect user to index page after sign out
  def after_sign_out_path_for(resource)
    home_index_path
  end
end
