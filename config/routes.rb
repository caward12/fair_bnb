Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
  
  root 'home#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  get '/sign_up', to: 'signup#index'
  get '/log_in', to: 'login#index'
  get  '/dashboard', to: 'dashboard#index'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:edit, :update, :show]
  resources :properties,  only: [:index, :show]
  resources :messages, only: [:index, :create]

end
