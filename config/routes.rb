Rails.application.routes.draw do
  root 'static_pages#top'
  get '/about', to: 'static_pages#about'
  get '/policy', to: 'static_pages#policy'
  get '/contact', to: 'static_pages#contact'
  get '/contract', to: 'static_pages#contract'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  post 'logout', to: 'user_sessions#destroy'
  get '/choices/result/:id', to: 'choices#result'

  resources :choices, only: %i[new create edit update] do
    collection do
      post :confirm
      get :confirm, :alert
    end
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
