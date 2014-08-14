class Withdrawal < ActiveRecord::Base
  belongs_to :member

  before_save :validate_withdrawal
  
  # Validate fields
  validates :description, presence: true
  validates :member_id, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1


  private

  # Validates Member's withdrawal transaction
  def validate_withdrawal
  	balance = member_current_savings(self.member_id)

  	if(self.amount > balance)
  		begin      	      
	      self.save
	    rescue
	      false
	    end
  	end
  end

   # Calculates Member's current savings
   def member_current_savings(member_id)

    # Check last withdrawal date
    last_withdrawal_txn = Withdrawal.where(:member_id => member_id).last

    # Fetch all remittances of the member in question since last withdrawal
    if last_withdrawal_txn.blank?
      contributions = Remittance.where(:member_id => member_id)
    else
      # Bug here..fix it later
      contributions = Remittance.where(:member_id => member_id).where(:created_at > last_withdrawal_txn.created_at)
    end

    # Sum all contributions
    contributions_sum = 0

    contributions.each do | contrib |
      contributions_sum += contrib.amount
    end

    contributions_sum
   end
end
