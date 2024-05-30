Rails.application.routes.draw do
  post 'register', to: 'users#register'
  post 'login', to: 'users#login'
  get 'profile', to: 'users#show'
  resources :beneficiaries, only: [:create, :update, :destroy]
  post 'transfer', to: 'transfers#create'
end
