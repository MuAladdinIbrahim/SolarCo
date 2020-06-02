Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :offers
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

  ######### ReviewsRoutes #########
  get 'offer_rates/per_contractor/:id', to: 'offer_rates#index'
  get 'offer_reviews/per_contractor/:id', to: 'offer_reviews#index'
  resources :offer_rates, except: [:index]
  resources :offer_reviews, except: [:index]
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
