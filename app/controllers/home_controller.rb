class HomeController < ApplicationController

  before_filter :authenticate_user! ,only: [:dashboard]

  # Landing page
  def index
    if signed_in?
      redirect_to home_dashboard_path
      return
    else
      # Make Login page the default page
     redirect_to new_user_session_path
    end
    #render(:layout => "layouts/landing")
  end

  def passthrough
    if current_user.role? :admin
      redirect_to admin_admin_index_path
    elsif current_user.role_ids == [2] 
      redirect_to home_dashboard_path
    end
  end

  # Renew service page
  def service_suspended
    render(:layout => "layouts/lockscreen")
  end

  # Chama homepage
  def dashboard
    # TO DO
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
  
# End Home
end
