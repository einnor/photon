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
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :phone_number, :national_id_number,:role_ids) }
  end

  def layout_by_resource
    if devise_controller? and !user_signed_in?
      'landing'
    else
      'application'
    end
  end

   # Calculates Chama's current savings
   def chama_current_savings
    chama_id = current_user.chama.id
    chama_members = Member.where(:chama_id => chama_id)

    # Check last withdrawal date
    withdrawal_txns = Withdrawal.where(:chama_id => chama_id)

    # Sum all withdrawals
    total_withdrawals = 0


    # Fetch all remittances of the member in question since last withdrawal
    if withdrawal_txns.blank?
      contributions = Remittance.where(:member_id => chama_members)
    else
      # Bug here..fix it later
      withdrawal_txns.each do | w_txn |
        total_withdrawals += w_txn.amount
      end

      contributions = Remittance.where(:member_id => chama_members)
    end

    # Sum all contributions
    contributions_sum = 0

    contributions.each do | contrib |
      contributions_sum += contrib.amount
    end

    contributions_sum - total_withdrawals
   end
end
