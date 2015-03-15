Paddle::Application.routes.draw do
  resources :users do 
    get 'search', on: :collection
  end
  resources :sessions,      only: [:new, :create, :destroy]
  resources :matches,       only: [:new, :create]
  root to: 'users#index'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
end
