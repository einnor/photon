class MessageManager < ActiveRecord::Base
  belongs_to :chama 

  # Validate Fields
  validates :sms_balance, presence: true
  validates :chama_id, presence: true
  validates_uniqueness_of :chama_id, :message => " has a Message Manager already."
  validates_numericality_of :sms_balance, :greater_than_or_equal_to => 0

  # Decrements SMS balance of a MessageManager by one
  def decrement_sms_balance
  	# Decrement SMS balance
  	bal = self.sms_balance
  	self.sms_balance = bal - 1

  	# Save changes
  	self.save
  end

  # Tops up SMS balance
  def top_up_sms(new_sms_count)
  	# increment SMS balance
  	bal = self.sms_balance + new_sms_count
  	self.sms_balance = bal

  	# Save changes
  	self.save
  end
end
