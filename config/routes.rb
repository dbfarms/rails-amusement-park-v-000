Rails.application.routes.draw do


  #resources :rides

  post '/rides/new' 

  resources :attractions

  resources :users
  
  #resources :sessions, only: [:new]
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  
  root 'static_pages#home'

end