class Chama < ActiveRecord::Base
  belongs_to :user
  has_many :members

  # Validate fields
  validates :name, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
  validates :chama_type, presence: true
  validates_numericality_of :approx_no_of_members, :only_integer => true, :greater_than_or_equal_to => 1
end
