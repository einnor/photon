class HomeController < ApplicationController

  before_filter :authenticate_user! ,only: [:dashboard]
  before_action :check_chama_service_validity, only: [:dashboard,:passthrough]

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

  # Renew service page
  def service_suspended
    render(:layout => "layouts/lockscreen")
  end

  # Chama homepage
  def dashboard
    @current_savings = chama_current_savings

    # Calculate total chama withdrawals
    chama_id = current_user.chama.id

    # Fetch all withdrawal transactions from chama in question
    withdrawal_txns = Withdrawal.where(:chama_id => chama_id)

    # Sum all withdrawals
    @total_withdrawals = 0

    # Sum all withdrawals
    if !withdrawal_txns.blank?
      withdrawal_txns.each do | w_txn |
        @total_withdrawals += w_txn.amount
      end
    end

    # Calculate total Disbursed Loans
    @total_loans = 0

    members = Member.where(:chama_id => chama_id)

    loans = Loan.where(:member_id => members).where(:loan_status == "ACCEPTED")

    loans.each do |loan|
      @total_loans +=loan.loan_amount_requested
    end

    # Calculate total penalties issued
    @total_penalties = 0

    penalties = Penalty.where(:member_id => members).where(:penalty_status == "PAYED")

    penalties.each do |penalty|
      @total_penalties += penalty.amount
    end

    # Display calendar of events on home page
    @events = Event.where(:chama_id => current_user.chama.id).paginate(:page => params[:page], :per_page => 5)

    # Compute monthly defaulters

    # Calculate this months deadline
    setting = Setting.where(:chama_id => chama_id)

    generic_deadline = nil

    setting.each do |s|
      generic_deadline = s.remittance_deadline
    end

    current_date = Date.today

    deadline_date = Date.new(current_date.year, current_date.month, generic_deadline.day) 

    #where(:created_at < deadline_date)
    # Fetch monthly remittance defaulters
    @remittances = Remittance.where(:member_id => members).where('updated_at < ?', deadline_date).paginate(:page => params[:page], :per_page => 10)
    

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
