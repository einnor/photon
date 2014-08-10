Rails.application.routes.draw do

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

end
