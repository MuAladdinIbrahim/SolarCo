Rails.application.routes.draw do
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
