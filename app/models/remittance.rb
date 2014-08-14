class Remittance < ActiveRecord::Base
  belongs_to :member

  validates :remittance_type, presence: true
  validates :member_id, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1
end
