Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Default route (troubleshooting)
  get '/', to: 'users#index'

  # User routes
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'
  post "users/logIn", to: "users#authenticate"
  post '/users', to: 'users#create'
  delete '/users/:id', to: 'users#delete'
  put '/users/:id', to: 'users#update'

  # Plane routes
  get '/planes', to: 'planes#index'
  get '/planes/:id', to: 'planes#show'
  post '/planes', to: 'planes#create'
  delete '/planes/:id', to: 'planes#delete'

end
