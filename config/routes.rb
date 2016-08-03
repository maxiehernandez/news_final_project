Rails.application.routes.draw do
  get 'news_rsses/new'

  get 'news_rsses/create'

  get 'stories/new'

  get 'stories/create'

  get 'soc_meds/new'

  get 'soc_meds/create'

  get 'soc_meds/publish'

  get 'soc_meds/delete'

  get 'soc_meds/refresh'

  root 'users#home'
  get 'users/home0'

  get 'news/home'

  resources :topics do
    collection { post :sort}
  end
  resources :users

  get '/dashboard' => 'users#dashboard'
  post '/dashboard'=> 'users#editor_search'


  get 'topics/create'
  get 'topics/new'
  post 'topics/new' => 'topics#create'
  get 'topics/index'
  get 'topics/show'
  get 'topics/form'

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
