Rails.application.routes.draw do
  root 'users#home'

  resources :stories
  resources :users
  resources :rss_feeds
  resources :topics do
    collection { post :sort}
  end

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  post '/youtubes' => 'youtubes#create'

  get '/dashboard' => 'users#dashboard'

  get 'topics/new'
  post 'topics/new' => 'topics#create'
  get 'topics/create'
  get 'topics/index'
  get 'topics/show'
  get 'topics/form'


  # get 'users/new'
  # get 'users/create'
  # get 'users/show'
  # get 'users/home0'
  # get 'news/home'

  get 'news_rsses/new'
  get 'news_rsses/create'

  get 'stories/new'
  post 'stories/create'
  get 'soc_meds/new'
  get 'soc_meds/create'
  get 'soc_meds/publish'
  get 'soc_meds/delete'
  get 'soc_meds/refresh'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
