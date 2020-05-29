Rails.application.routes.draw do
  resources :offers
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :posts
  resources :calculations
  resources :systems
  resources :users

  ###### Clients Routes #######
  put 'clients/avatar/:id', to: 'clients#updateAvatar'
  get 'clients/:id', to: 'clients#show'
  #############################

  ###### Contractor Routes #######
  put 'contractors/:id', to: 'contractors#update'
  #############################

  ###### offers Route to get all offers on post #######
  get 'offers/post/:id', to: 'offers#getOffers'
  #############################
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
