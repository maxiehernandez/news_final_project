Rails.application.routes.draw do
  get 'topics/create'

  get 'topics/new'

  get 'topics/index'

  get 'topics/show'

  root 'editors#dashboard'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
