require 'rufus-scheduler'

#
# Automate SMS Sending
#
scheduler = Rufus::Scheduler.new

# Loop through all Chamas
@chamas = Chama.all


@chamas.each do | chama |
  # Get Chama setting
  @setting = chama.setting

  @remittance_deadline = @setting.remittance_deadline
  @grace_period_id_days = @setting.warning_days_before_deadline
  @reminder_date = @remittance_deadline - @grace_period_id_days

  dead_line = DateTime.parse(@remittance_deadline.to_s)
  rem_date = DateTime.parse(@reminder_date.to_s)

  last_month_deadline = dead_line - 1.month

  # Fetch All Chama Members
  @members = Member.where(:chama_id => chama.id)

  #Fetch all Member Contribution of a chama
  @contribution = Remittance.where(:member_id => @members)

  # Send Remittance Reminder Message
  scheduler.cron '10 8 ' + rem_date.day.to_s + ' * *' do
    # Check those who have payed by this date.
    @contribution_white_lst = Remittance.where(:member_id => @members).where(:created_at > last_month_deadline)

    # Corresponding Members
    paid_members_arr = Array.new
    @contribution_white_lst.each do |c |
      paid_members_arr << c.member_id
    end

    paid_members = Member.where(:id => paid_members_arr)

    # Get Those who have not paid
    not_paid = @members - paid_members

    # Send each member a reminder msg
    not_paid.each do | member |
      
      #send SMS
      message_params = Hash.new
      # Populate Hash
      message_params = {
        :body => @setting.remittance_reminder_sms,
        :recepient => member.phone_number,
        :message_manager_id => chama.message_manager.id ,
      }


      @message = Message.new(message_params)

      @message_manager = chama.message_manager

      if @message.save

        # Send SMS Here
        if (!@message.recepient.blank? && !@message.body.blank?)

          # Check if user has balance
          if @message_manager.sms_balance > 0
           send_sms(@message.recepient, @message.body,@message)
          else
            @message.update_AIT_reponse("ERROR", "LOW-SMS-BALANCE", "ERROR", "ERROR")
          end
        end

      else
        # Error Saving SMS to database

        # End if
      end
    end
  end


  # Send Remittance Penalty Message
  scheduler.cron '10 8 ' + dead_line.day.to_s + ' * *' do
    # Check those who have payed by this date.
    @contribution_white_lst = Remittance.where(:member_id => @members).where(:created_at > last_month_deadline)

    # Corresponding Members
    paid_members_arr = Array.new
    @contribution_white_lst.each do |c |
      paid_members_arr << c.member_id
    end

    paid_members = Member.where(:id => paid_members_arr)

    # Get Those who have not paid
    not_paid = @members - paid_members

    # Send each member a reminder msg
    not_paid.each do | member |
      

      #Penalty json
      penalty_json = Hash.new 
      penalty_json = {
        :penalty_type => "LATE-REMITTANCE",
        :amount => @setting.penalty_amount,
        :due_date => @remittance_deadline + @setting.penalty_repay_periods_in_days,
        :penalty_status => "NOT-PAYED",
        :member_id => member.id
      }

      #Create Penalty record
      penalty = Penalty.new(penalty_json)

      # Save
      penalty.save

      # Send SMS
      message_params = Hash.new
      # Populate Hash
      message_params = {
        :body => @setting.penalty_reminder_sms,
        :recepient => member.phone_number,
        :message_manager_id => chama.message_manager.id ,
      }


      @message = Message.new(message_params)

      @message_manager = chama.message_manager

      if @message.save

        # Send SMS Here
        if (!@message.recepient.blank? && !@message.body.blank?)

          # Check if user has balance
          if @message_manager.sms_balance > 0
           send_sms(@message.recepient, @message.body,@message)
          else
            @message.update_AIT_reponse("ERROR", "LOW-SMS-BALANCE", "ERROR", "ERROR")
          end
        end

      else
        # Error Saving SMS to database

        # End if
      end
    # End member loop
    end
  # End scheduler
  end
# End chama loop
end


# Send an SMS
def send_sms(to, message, message_obj)

  # Specify your login credentials
  username = "trendprosystems";
  apikey   = "1f60b6b8df1951d9d7b8447c58c22a27488096fc7181e5177397d146f0036b6c";

  # Specify the numbers that you want to send to in a comma-separated list
  # Please ensure you include the country code (+254 for Kenya in this case)
  #to      = "+254711XXXYYYZZZ,+254733XXXYYYZZZ";

  # And of course we want our recipients to know what we really do
  # message = "I'm a lumberjack and it's ok, I sleep all night and I work all day"

  # Create a new instance of our awesome gateway class
  gateway = Messaging::AfricasTalkingGateway.new(username, apikey)

  # Any gateway errors will be captured by our custom Exception class below,
  # so wrap the call in a try-catch block
  begin
    # Thats it, hit send and we'll take care of the rest.
    reports = gateway.send_message(to, message)
    reports.each {|x|
      # Note that only the Status "Success" means the message was sent
      #puts 'number=' + x.number + ';status=' + x.status + ';messageId=' + x.messageId + ';cost=' + x.cost

      #Update message with AIT response
      message_obj.update_AIT_reponse(x.number, x.status, "msg_id", x.cost)
    }
  rescue Messaging::AfricasTalkingGatewayError => ex
    #puts 'Encountered an error: ' + ex.message

    # Update message with error 
    message_obj.update_AIT_reponse("ERROR", "ERROR", "ERROR", "ERROR")
  end
  # DONE!
end