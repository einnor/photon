class SmsFee < ActiveRecord::Base
  belongs_to :chama
   
  # Enforce validations on fields
  validates :package, presence: true
  validates :chama_id, presence: true
  #validates :txn_status, presence: true
  #validates :pesapal_txn_tracking_id, presence: true
  #validates :pesapal_merchant_reference, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1
end
