class SmsFee < ActiveRecord::Base
  belongs_to :chama
   
  # Enforce validations on fields
  validates :package, presence: true
  validates :chama_id, presence: true
  #validates :txn_status, presence: true
  #validates :pesapal_txn_tracking_id, presence: true
  #validates :pesapal_merchant_reference, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1


  # Updates Pesapal details when the transaction goes through.
  def update_pesapal_details(txn_tracking_id, merchant_ref)
  	# Update details
  	self.pesapal_txn_tracking_id = txn_tracking_id
  	self.pesapal_merchant_reference = merchant_ref

  	# Save the changes
  	self.save
  end

  # Handles Pesapal Instant Payment Notifications
  def update_payment_status new_status
  	#Update status
  	self.txn_status = new_status

  	# save changes
  	self.save
  end
end
