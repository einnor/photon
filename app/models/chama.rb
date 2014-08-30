class Chama < ActiveRecord::Base
  belongs_to :user
  has_many :members, dependent: :destroy

  # Set up chama
  after_save :setup_chama
  
  has_many :events, dependent: :destroy
  has_one :message_manager, dependent: :destroy
  has_many :sms_fees, dependent: :destroy
  has_many :service_feesing, dependent: :destroy
  has_one :setting, dependent: :destroy
  has_many :withdrawals, dependent: :destroy

  # Validate fields
  validates :name, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
  validates :chama_type, presence: true
  validates_numericality_of :approx_no_of_members, :only_integer => true, :greater_than_or_equal_to => 1

  # A chama Admin can only manage one chama
  validates_uniqueness_of :user_id, :message => " (Chama admin) has a Chama already."


  # Sets up a Chama
  # It Creates a Settings, ServiceFee and MessageManager record for the given 
  # Chama
  def setup_chama
    date = Date.today
    next_month = date >> 1

    # Set up Chama Settings
    setting_json = Hash.new
    setting_json = {
      :remittance_deadline => date,
      :warning_days_before_deadline => 3,
      :remittance_reminder_sms => "Hi, please be reminded to make your chama contribution in 3 days.",
      :penalty_reminder_sms => "Hi, you have delayed making your Chama monthly contribution and you 
                                have been penalized.",
      :penalty_type => "FLAT",
      :penalty_amount => 300.0,
      :penalty_repay_periods_in_days => 30,
      :chama_id => self.id
    }

    # Create seting record
    setting = Setting.new(setting_json)

    # Save
    setting.save

    # Set Up Message Manager
    message_manager_json = Hash.new
    message_manager_json = {
      :sms_balance => 5,
      :chama_id => self.id
    }

    # Create Message Manager
    message_manager = MessageManager.new(message_manager_json)

    # Save
    message_manager.save

    # Set up Service Payment.
    # Give Chama 1 month trial period
    service_fee_json = Hash.new
    service_fee_json  = {
      :payment_type => "REGISTRATION-FEE",
      :amount => 10000.0,
      :description => "Registration fee for " + self.name.to_s,
      :next_payment_due_date => next_month,
      :service_status => "OK",
      :txn_status => "COMPLETED",
      :pesapal_txn_tracking_id => "",
      :pesapal_merchant_reference => "",
      :chama_id => self.id
    }

    # Create Service Fee Record for the Chama
    service_fee = ServiceFee.new(service_fee_json)

    # Save 
    service_fee.save

  end
#End of class
end
