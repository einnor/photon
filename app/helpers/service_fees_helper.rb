module ServiceFeesHelper
 #
  # This Class handles Pesapal checkout process
  #
  class PesaPalInterface
    attr_reader :pesapal
    
    def initialize
      # Sets environment intelligently to 'Rails.env' (if Rails) or :development (if non-Rails)
      @pesapal = Pesapal::Merchant.new

      # Reconfigure Pesapal Gateway
      @pesapal.config = {  :callback_url => 'http://localhost:8080/service_fees/pesapal_success',
                    :consumer_key => 'qXiKd4Mp4109RzTa0t71MS6IEiE+SSim',
                    :consumer_secret => 'tI0s6AY64kMk5f5EDQNn7btPxb0='
                  }                
    end
    
    # Sets Pesapal parameters when renewing Chama Service Fee
    def set_service_bundle_details(service_fee, current_user)
      @pesapal.order_details = {  :amount => service_fee_amount(current_user.chama),
                                  :description => "Renewing SmartChama Service for the Next three months",
                                  :type => 'MERCHANT',
                                  :reference => service_fee.id,
                                  :first_name => current_user.name,
                                  :last_name => '.',
                                  :email => current_user.email,
                                  :phonenumber => current_user.phone_number,
                                  :currency => 'KES'
                                }
    end
    
    def do_payment
      # generate transaction url
      service_bundle_url = @pesapal.generate_order_url 
     
     return service_bundle_url
    end

    private

    # Calculates service fee of a Chama for 3 Months
    def service_fee_amount chama
      approx_no_of_members = chama.approx_no_of_members
      fee_amount = 0

      # Do market research to set these values
      if approx_no_of_members <= 10
        fee_amount = 3000
      elsif (approx_no_of_members > 10 && approx_no_of_members <= 20)
        fee_amount = 6000
      elsif (approx_no_of_members > 20 && approx_no_of_members <= 30)
        fee_amount = 9000
      elsif (approx_no_of_members > 30 && approx_no_of_members <= 40)
        fee_amount = 12000
      elsif (approx_no_of_members > 40 && approx_no_of_members <= 50)
        fee_amount = 15000
      elsif (approx_no_of_members > 50)
        fee_amount = 25000
      end
        return fee_amount
    end
  # End Class
  end
# End Module
end
