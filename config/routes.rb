Rails.application.routes.draw do

  root 'dashboard#index'

  post 'show'=>'dashboard#show', as: :show
end
