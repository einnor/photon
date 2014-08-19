class Message < ActiveRecord::Base
  belongs_to :message_manager 

  after_save :update_message_manager

  # Validate Fields 
  validates :body, presence: true
  validates :recepient, presence: true
  validates :message_manager_id, presence: true

  # Updates Message record with AIT API Response
  def update_AIT_reponse(number, status, ait_messageId, cost)

  	# Update fields
  	self.number = number
  	self.status = status
  	self.msg_id = ait_messageId
  	self.cost = cost


  	#save
  	self.save

  end

  # Updates message manager
  def update_message_manager
  	@message_manager = MessageManager.find(self.message_manager_id)

  	if self.status == "Success"
  		@message_manager.decrement_sms_balance
  	end
  end
end
