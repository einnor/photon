class Penalty < ActiveRecord::Base
  	belongs_to :member
  	has_many :penalty_repayments, dependent: :destroy

	# Validate all fields
	validates :penalty_type, presence: true
	validates :due_date, presence: true
	validates :penalty_status, presence: true
	validates :member_id, presence: true
	validates_numericality_of :amount, :greater_than_or_equal_to => 1

	# Returns name of penalty bearer and the issues penalty
	def member_name
		res = self.member.name.to_s + " - " +  self.penalty_type.to_s
		res
	end
end
