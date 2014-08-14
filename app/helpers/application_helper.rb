module ApplicationHelper

  # Example code. Delete later
  def valid_user(role_id)
    valid_gms = Array.new
    User.all.each do |user|
      if user.role_ids == [role_id] 
        valid_gms << user
      end
    end
    valid_gms
   end

   # Calculates the Loan to be repayed
   def loan_to_repay()
   	members = Member.where(:chama_id => current_user.chama.id)
    loans = Loan.where(:member_id => members).where(:loan_status => "ACCEPTED")
   end

   def authorized_members()
   	members = Member.where(:chama_id => current_user.chama.id)
   end
end
