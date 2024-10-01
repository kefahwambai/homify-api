Rails.application.routes.draw do
  resources :home_owners, only: [:index, :show, :create, :update, :destroy]
  resources :houses, only: [:index, :show, :create, :update, :destroy]
  resources :home_buyers, only: [:index, :show, :create, :update, :destroy]
  resources :purchases, only: [:index, :show, :create, :destroy]


  post '/signup/owner', to: 'home_owners#create'
  post '/signup/buyer', to: 'home_buyers#create'
  
  post 'auth/login', to: 'sessions#create'
  delete 'auth/logout', to: 'sessions#destroy'
end
