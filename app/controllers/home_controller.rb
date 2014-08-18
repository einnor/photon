class HomeController < ApplicationController

  before_filter :authenticate_user! ,only: [:dashboard]

  # Landing page
  def index
    if signed_in?
      redirect_to home_dashboard_path
      return
    end
    render(:layout => "layouts/landing")
  end

  def passthrough
    #check whether chama has renewed service
    @service_fee = ServiceFee.where(:chama_id => current_user.chama.id).last

    if current_user.role? :admin
      redirect_to admin_admin_index_path
    elsif current_user.role_ids == [2] 
      
      # Check if user has renewed service
      if @service_fee.service_status != "OK"
        # Service not renewed or service status is not OK
        redirect_to home_service_suspended_path
      else
        # Service status is OK
        redirect_to home_dashboard_path
      end    
    end
  end

  # Renew service page
  def service_suspended
    render(:layout => "layouts/lockscreen")
  end

  # Chama homepage
  def dashboard
    #check whether chama has renewed service
    @service_fee = ServiceFee.where(:chama_id => current_user.chama.id).last
    
    # Check if user has renewed service
    if @service_fee.service_status != "OK"
      # Service not renewed or service status is not OK
      redirect_to home_service_suspended_path
    else
      # Service status is OK
      redirect_to home_dashboard_path
    end    
  end

  # Contact us page
  def contact
  end

  # About Us page
  def about
  end

  # Help page
  def help
  end
end
