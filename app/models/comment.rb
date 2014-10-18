class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  # Validate fields
  validates :user_id, presence: true
  validates :content, presence: true
end
