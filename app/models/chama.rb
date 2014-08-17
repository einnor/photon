class Chama < ActiveRecord::Base
  belongs_to :user
  has_many :members
  has_many :events
  has_one :message_manager

  # Validate fields
  validates :name, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
  validates :chama_type, presence: true
  validates_numericality_of :approx_no_of_members, :only_integer => true, :greater_than_or_equal_to => 1

  # A chama Admin can only manage one chama
  validates_uniqueness_of :user_id, :message => " (Chama admin) has a Chama already."

end
