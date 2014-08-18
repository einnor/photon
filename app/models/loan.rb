class Loan < ActiveRecord::Base
  	belongs_to :member
  	has_many :loan_repayments, dependent: :destroy


	# Validate all fields
	validates :loan_interest_method, presence: true
	validates :loan_status, presence: true
	validates :installment_repay_deadline, presence: true
	validates :member_id, presence: true

	validates_numericality_of :loan_amount_requested, :greater_than_or_equal_to => 1
	validates_numericality_of :repay_period_in_months, :greater_than_or_equal_to => 1
	validates_numericality_of :interest_rate_pa, :greater_than_or_equal_to => 0
	validates_numericality_of :monthly_installments, :greater_than_or_equal_to => 1
	validates_numericality_of :repay_amount, :greater_than_or_equal_to => 1

	# Returns name of Loan Holder 
	def member_name
		self.member.name
	end

end
