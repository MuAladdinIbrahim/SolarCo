Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :posts
  resources :calculations
  resources :systems
  resources :users
  put 'clients/avatar/:id', to: 'client#updateAvatar'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
