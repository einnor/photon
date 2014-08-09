Rails.application.routes.draw do

  devise_for :users

  get 'home/index'

  get 'home/dashboard'

  get 'home/contact'

  get 'home/about'

  get 'home/help'

  root :to => 'home#index'

end
