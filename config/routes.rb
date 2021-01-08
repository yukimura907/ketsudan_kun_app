Rails.application.routes.draw do
  root 'static_pages#top'
  get '/about', to: 'static_pages#about'
  get '/policy', to: 'static_pages#policy'
  get '/contact', to: 'static_pages#contact'
  get '/contract', to: 'static_pages#contract'

  resources :users, only: %i[new create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  post 'logout', to: 'user_sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
