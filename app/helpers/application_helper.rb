module ApplicationHelper
   #
   # Helper methods used across the SmartChama application.
   #

   # Calculates the Loan to be repayed
   def loan_to_repay()
   	members = Member.where(:chama_id => current_user.chama.id)
    loans = Loan.where(:member_id => members).where(:loan_status => "ACCEPTED")
   end

   # Fetches only the right Members
   def authorized_members()
   	members = Member.where(:chama_id => current_user.chama.id)
   end

   # Calculates the Penalties to be repayed
   def penalty_to_repay
   	members = Member.where(:chama_id => current_user.chama.id)
    penalties = Penalty.where(:member_id => members).where(:penalty_status => "NOT-PAYED")
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

   # Returns Current Users Chama Message Manager
   def correct_message_manager(current_user)
    current_user.chama.message_manager
   end

   # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "SmartChama | Run your Chama the Smart way"
      if page_title.empty?
        base_title
      else
        "#{base_title} | #{page_title}"
      end
  end
  
  def bootstrap_class_for flash_type
      { success: "alert-success", error: "alert-error", alert: "alert-warning", notice: "alert-success" }[flash_type.to_sym] || flash_type.to_s
  end
     
  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
      concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
      concat message end)
    end
    nil
  end

  # Retrieves users name given a phone number
  def member_name_from_phone(tel)
    mem = Member.where(:phone_number => tel)
    res = 'Member Name'
    mem.each do | m |
       res = m.name 
    end
    res
  end
end
