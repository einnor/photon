class Message < ActiveRecord::Base
  belongs_to :message_manager 

  # Validate Fields 
  validates :body, presence: true
  validates :recepient, presence: true
  validates :message_manager_id, presence: true
end
