class Withdrawal < ActiveRecord::Base
  belongs_to :chama

  before_save :validate_withdrawal
  
  # Validate fields
  validates :description, presence: true
  validates :chama_id, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1


  private

  # Validates Member's withdrawal transaction
  def validate_withdrawal
  	balance = chama_current_savings
  	if(self.amount > balance)
  		begin      	      
	      self.save
	    rescue
	      false
	    end
  	end
  end

   # Calculates Chama's current savings
   def chama_current_savings
    chama_id = self.chama_id
    chama_members = Member.where(:chama_id => chama_id)

    # Check last withdrawal date
    withdrawal_txns = Withdrawal.where(:chama_id => chama_id)

    # Sum all withdrawals
    total_withdrawals = 0


    # Fetch all remittances of the member in question since last withdrawal
    if withdrawal_txns.blank?
      contributions = Remittance.where(:member_id => chama_members)
    else
      # Bug here..fix it later
      withdrawal_txns.each do | w_txn |
        total_withdrawals += w_txn.amount
      end

      contributions = Remittance.where(:member_id => chama_members)
    end

    # Sum all contributions
    contributions_sum = 0

    contributions.each do | contrib |
      contributions_sum += contrib.amount
    end

    contributions_sum - total_withdrawals
   end
end
