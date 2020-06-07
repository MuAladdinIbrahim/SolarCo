Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount ActionCable.server => '/cable'

  resources :offers
  resources :posts
  resources :users
  resources :offers

  mount_devise_token_auth_for 'User', at: 'user/auth'
  mount_devise_token_auth_for 'Contractor', at: 'contractor/auth'
  as :contractor do
    # Define routes for Contractor within this block.
  end

  ######## Calculations Routes #########
  post 'geocoder', to: 'geocoder#getLocation'
  resources :calculations, only: [:index, :show]
  ###################################################
  
  ######### Systems Routes #########
  resources :systems, only: [:index, :create, :destroy]
  ###################################################

  ######### Chat Routes #########
  get 'messages/:user_id/:contractor_id', to: 'messages#index'
  ###################################################

  ######### ReviewsRoutes #########
  get 'offer_rates/per_contractor/:id', to: 'offer_rates#index'
  get 'offer_reviews/per_contractor/:id', to: 'offer_reviews#index'
  resources :offer_rates, only: []
  resources :offer_reviews, only: []
  ###################################################

  ######## Clients Routes #########
  put 'clients/avatar/:id', to: 'clients#updateAvatar'
  resources :clients, only: [:show, :update]
  # get 'clients/:id', to: 'clients#show'
  # put 'clients/:id', to: 'clients#update'
  ###################################################

  ######## Contractor Routes #########
  put 'contractors/avatar/:id', to: 'contractors#updateAvatar'
  resources :contractors, only: [:show, :update]
  # get 'contractors/:id', to: 'contractors#show'
  # put 'contractors/:id', to: 'contractors#update'
  ###################################################

  ######## offers Route to get all offers on post #########
  get 'offers/post/:post_id', to: 'offers#getOffers'
  ###################################################
end
