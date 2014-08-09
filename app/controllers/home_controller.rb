class HomeController < ApplicationController

  before_filter :authenticate_user! ,only: [:dashboard]

  def index
    render(:layout => "layouts/landing")
  end

  def dashboard
  end

  def contact
  end

  def about
  end

  def help
  end
end
