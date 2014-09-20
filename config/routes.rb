Rails.application.routes.draw do

  root 'dashboard#index'

  post 'show'=>'dashboard#show', as: :show

  resources :users
  match 'login'=>'users#login', via: [ :get, :post ], as: :login
  get 'logout'=>'users#logout', as: :logout


  get 'accounts/refresh'=>'accounts#refresh', as: :refresh_accounts
  resources :accounts

  post 'tokens/request'=>'tokens#request_token', as: :request_token
  post 'tokens/request/mfa'=>'tokens#request_mfa_code', as: :request_mfa_code
  post 'tokens/submit/mfa'=>'tokens#submit_mfa_code', as: :submit_mfa_code
  resources :tokens

  get  'widgets'=>'widgets#index', as: :widgets
  get  'widget/:name/add'=>'widgets#add', as: :add_widget
  post 'widget/:name/add'=>'widgets#configure', as: :configure_widget



end
