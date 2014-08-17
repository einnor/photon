class MessageManager < ActiveRecord::Base
  belongs_to :chama 

  # Validate Fields
  validates :sms_balance, presence: true
  validates :chama_id, presence: true
  validates_uniqueness_of :chama_id, :message => " has a Message Manager already."
  validates_numericality_of :sms_balance, :greater_than_or_equal_to => 0
end
