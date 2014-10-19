Rails.application.routes.draw do

  resources :authentications

  resources :comments

  resources :posts do
    collection do
      get :like_post
    end
  end

  # Home routes
  get 'home/index'

  get 'home/dashboard'

  get 'home/contact'

  get 'home/about'

  get 'home/help'

  get 'home/passthrough'

  get 'home/service_suspended'

  get 'admin/admin/index'

  
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  
  root :to => 'home#index'
  

  namespace :admin do
    resources :users
  end
  
# End routes
end
