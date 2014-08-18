Rails.application.routes.draw do

  resources :service_fees

  resources :sms_fees

  resources :messages

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

  get 'admin/admin/index'

  devise_for :users

  
  root :to => 'home#index'
  

  namespace :admin do
    resources :users
  end

  # Custom Routes
  match "messages/msg_manager/:id", :controller => "messages", :action => "msg_manager", :as => :msg_manager, via: [:get]
end
