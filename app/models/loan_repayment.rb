class LoanRepayment < ActiveRecord::Base
  belongs_to :loan

  # Validate fields
  validates :loan_id, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1
end
