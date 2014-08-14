class PenaltyRepayment < ActiveRecord::Base
  belongs_to :penalty

  before_save :update_penalty

  # Validate fields
  validates :penalty_id, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1

  private

  #Updates corresponding Penalty table
  def update_penalty
  	penalty = Penalty.find(self.penalty_id)

  	if(self.amount == penalty.amount || self.amount > penalty.amount)
  		begin      
	      penalty.penalty_status = "PAYED"
	      
	      penalty.save
	    rescue
	      false
	    end
  	end
  end
end
