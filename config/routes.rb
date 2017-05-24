Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
  
  root 'home#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  get '/sign_up', to: 'signup#index'
  get '/log_in', to: 'login#index'
  get  '/dashboard', to: 'dashboard#index'
  delete '/logout', to: 'sessions#destroy'

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :properties, only: [:index, :edit, :update]
    resources :users, only: [:index]
  end
  
  resources :conversations, only: [:show, :index]
  resources :messages, only: [:create]

  resources :users, only: [:edit, :update, :show]
  resources :properties,  only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :reservations, only: [:new]
  
  namespace :user do
    resources :properties, only: [:index]
  end

end
