Rails.application.routes.draw do
  resources :offers
  mount_devise_token_auth_for 'User', at: 'user/auth'

  mount_devise_token_auth_for 'Contractor', at: 'contractor/auth'
  as :contractor do
    # Define routes for Contractor within this block.
  end
  resources :posts
  resources :users
  
  ######## Calculations Routes #########
  post 'geocoder', to: 'geocoder#getLocation'
  get 'pv-calculation', to: 'calculations#index'
  get 'pv-calculation/:id', to: 'calculations#show'
  post 'pv-calculation', to: 'calculations#create'
  delete 'pv-calculation/:id', to: 'calculations#destroy'
  ###################################################
  
  ######### Systems Routes #########
  ###################################################

  ######## Clients Routes #########
  put 'clients/avatar/:id', to: 'clients#updateAvatar'
  get 'clients/:id', to: 'clients#show'
  ###################################################

  ######## Contractor Routes #########
  put 'contractors/:id', to: 'contractors#update'
  ###################################################

  ######## offers Route to get all offers on post #########
  get 'offers/post/:id', to: 'offers#getOffers'
  ###################################################
end
