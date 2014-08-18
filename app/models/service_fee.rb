class ServiceFee < ActiveRecord::Base
  belongs_to :chama
   
  # Enforce validations on fields
  validates :payment_type, presence: true
  validates :chama_id, presence: true
  validates :next_payment_due_date, presence: true
  validates :service_status, presence: true
  validates :chama_id, presence: true
  #validates :description, presence: true
  #validates :txn_status, presence: true
  #validates :pesapal_txn_tracking_id, presence: true
  #validates :pesapal_merchant_reference, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1
end
