Rails.application.routes.draw do

  get 'secret/public_info'

  get 'secret/secret'

  resources :posts

  resources :users, only: [:new, :index, :create]

  get 'login', to: 'sessions#new'
  resources :sessions, only: [:new, :create, :destroy]

  delete "/logout", to: 'sessions#destroy'

  get '/posts/:id/like', to: 'posts#like_post'

  #create a home page for the user
  get '/users/home', to: 'users#home'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'sessions#new'


end
