Rails.application.routes.draw do
  root 'editors#dashboard'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'


  get 'users/new'
  get 'users/create'
  get 'users/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
