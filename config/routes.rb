Rails.application.routes.draw do

  root 'dashboard#index'

  post 'show'=>'dashboard#show', as: :show

  resources :users

  match 'login'=>'users#login', via: [ :get, :post ], as: :login
  get 'logout'=>'users#logout', as: :logout

  resources :accounts

end
