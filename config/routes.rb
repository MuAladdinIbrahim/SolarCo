Rails.application.routes.draw do
  resources :offers
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :posts
  resources :users
  
  ######## Calculations Routes #########
  get 'pv-calculation/:id', to: 'calculations#show'
  post 'pv-calculation', to: 'calculations#create'
  delete 'pv-calculation/:id', to: 'calculations#destroy'
  ###################################################
  
  ######### Systems Routes #########
  # get 'user-info'
  post 'geocoder', to: 'geocoder#getLocation'
  # get 'system-info', to: 'systems#show'
  # post 'system-info', to: 'systems#create'
  # delete 'system-info/:id', to: 'systems#destroy'
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
