Rails.application.routes.draw do
  root 'static_pages#top'
  get '/about', to: 'static_pages#about'
  get '/policy', to: 'static_pages#policy'
  get '/contact', to: 'static_pages#contact'
  get '/contract', to: 'static_pages#contract'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
