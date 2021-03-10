Rails.application.routes.draw do
  root 'static_pages#top'
  get '/about', to: 'static_pages#about'
  get '/policy', to: 'static_pages#policy'
  get '/contact', to: 'static_pages#contact'
  get '/contract', to: 'static_pages#contract'
  # get 'login', to: 'user_sessions#new'
  # post 'login', to: 'user_sessions#create'
  post 'logout', to: 'user_sessions#destroy'
  # get '/choices/result/:id', to: 'choices#result'
  post '/oauth/callback', to: 'oauths#callback'
  get '/oauth/callback', to: 'oauths#callback'
  get '/oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider

  resources :choices, only: [:new, :create, :edit, :update, :index, :show] do
    collection do
      post :confirm, :compassion, :compassion_create
      get :alert
    end
    member do
      get :result
    end
  end

  namespace :guests do
    resources :choices, only: [:new, :create, :edit] do
      collection do
        post :confirm, :result
      end
    end
  end

  resources :users, only: [:show, :edit, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
