Paddle::Application.routes.draw do
  resources :users
  resources :sessions,      only: [:new, :create, :destroy]
  resources :matches,       only: [:new, :create]
  root to: 'pages#home'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
end
