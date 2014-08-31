Rails.application.routes.draw do

  resources :settings

  resources :service_fees do
    collection do
      get :pesapal_success
      get :pesapal_ipn
    end
  end

  resources :sms_fees do
    collection do
      get :pesapal_success
      get :pesapal_ipn
    end
  end


  resources :messages #do
    #collection do
      #get :msg_manager,:id
   # end
  #end

  resources :message_managers

  resources :events

  resources :withdrawals

  resources :penalty_repayments

  resources :penalties

  resources :loan_repayments

  resources :loans

  resources :remittances

  resources :members

  resources :chamas

  get 'home/index'

  get 'home/dashboard'

  get 'home/contact'

  get 'home/about'

  get 'home/help'

  get 'home/passthrough'

  get 'home/service_suspended'

  get 'admin/admin/index'

  devise_for :users

  
  root :to => 'home#index'
  

  namespace :admin do
    resources :users
  end

  # Custom Routes
  match "sms_fees/check_out/:id", :controller => "sms_fees", :action => "check_out", :as => :sms_check_out, via: [:get]
  match "messages/msg_manager/:id", :controller => "messages", :action => "msg_manager", :as => :msg_manager, via: [:get]
end
