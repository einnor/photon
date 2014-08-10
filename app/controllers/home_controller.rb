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
    if current_user.role? :admin
      redirect_to admin_admin_index_path
    elsif current_user.role_ids == [2] 
      redirect_to home_dashboard_path
    end
  end

  # Chama homepage
  def dashboard
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
