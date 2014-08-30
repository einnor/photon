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

    # If transaction status is COMPLETED 
    # update next payment date
    if new_status == 'COMPLETED'
      c_next_payment_due_date = self.next_payment_due_date
      c_next_payment_due_date >> 3

      self.next_payment_due_date = c_next_payment_due_date
    end
    
    #Update status
    self.txn_status = new_status

    # save changes
    self.save
  end
end
