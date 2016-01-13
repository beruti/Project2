Rails.application.routes.draw do

  get '/posts/build'

  get 'secret/public_info'

  get 'secret/secret'

  resources :charges

  resources :posts

  resources :users, only: [:new, :index, :create, :edit, :update, :destroy]

  get 'login', to: 'sessions#new'
  
  resources :sessions, only: [:new, :create]

  delete "/logout", to: 'sessions#destroy'

  get '/posts/:id/like', to: 'posts#like_post'

  #create a home page for the user
  get '/users/:id/home', to: 'users#home'

  post '/posts/:id/archive', to: 'posts#archived', as: :archive

  post '/posts/:id/unarchive', to: 'posts#unarchived', as: :unarchive


  root 'sessions#new'

end
