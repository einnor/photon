Rails.application.routes.draw do

  devise_for :users

  get 'home/index'

  get 'home/dashboard'

  get 'home/contact'

  get 'home/about'

  get 'home/help'

  get 'home/passthrough'

  root :to => 'home#index'

  get 'admin/admin/index'

  namespace :admin do
    resources :users
  end

end
