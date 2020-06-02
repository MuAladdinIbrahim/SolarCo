Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :offer_rates
  resources :offer_reviews
  resources :offers
  resources :reviews
  resources :posts
  resources :users
  
  mount_devise_token_auth_for 'User', at: 'user/auth'
  mount_devise_token_auth_for 'Contractor', at: 'contractor/auth'
  as :contractor do
    # Define routes for Contractor within this block.
  end

  ######## Calculations Routes #########
  post 'geocoder', to: 'geocoder#getLocation'
  resources :calculations, except: [:update]
  ###################################################
  
  ######### Systems Routes #########
  resources :systems, only: [:index, :create]
  ###################################################

  ######## Clients Routes #########
  put 'clients/avatar/:id', to: 'clients#updateAvatar'
  get 'clients/:id', to: 'clients#show'
  put 'clients/:id', to: 'clients#update'
  ###################################################

  ######## Contractor Routes #########
  get 'contractors/:id', to: 'contractors#show'
  put 'contractors/:id', to: 'contractors#update'
  put 'contractors/avatar/:id', to: 'contractors#updateAvatar'
  ###################################################

  ######## offers Route to get all offers on post #########
  get 'offers/post/:post_id', to: 'offers#getOffers'
  ###################################################
end
