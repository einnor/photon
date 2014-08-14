class Penalty < ActiveRecord::Base
  	belongs_to :member

	# Validate all fields
	validates :penalty_type, presence: true
	validates :due_date, presence: true
	validates :penalty_status, presence: true
	validates :member_id, presence: true
	validates_numericality_of :amount, :greater_than_or_equal_to => 1
end
