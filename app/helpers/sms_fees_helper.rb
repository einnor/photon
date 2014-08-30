require 'pesapal'

module SmsFeesHelper
  #
  # This Class handles Pesapal checkout process
  #
  class PesaPalInterface
    attr_reader :pesapal
    
    def initialize
      # Sets environment intelligently to 'Rails.env' (if Rails) or :development (if non-Rails)
      @pesapal = Pesapal::Merchant.new                
    end
    
    def set_sms_bundle_details(sms_fee, current_user)
      @pesapal.order_details = {  :amount => sms_fee.amount,
                                  :description => "Buying of SMS bundle."+ sms_fee.package,
                                  :type => 'MERCHANT',
                                  :reference => sms_fee.id,
                                  :first_name => current_user.name,
                                  :last_name => '.',
                                  :email => current_user.email,
                                  :phonenumber => current_user.phone_number,
                                  :currency => 'KES'
                                }
     
    end
    
    def do_payment
      # generate transaction url
      sms_bundle_url = @pesapal.generate_order_url 
     
     return sms_bundle_url
    end
    
  end
end
