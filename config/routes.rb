Rails.application.routes.draw do

  resources :projects, param: :slug do
    resources :todos do
      # resources :user_todos, only: [:new, :create]
      get '/affectation/new' => 'todos#addUser'
      post '/affectation' => 'todos#affectation'
    end
  end

  resources :users, only: [:new, :create, :edit, :update, :show]
  resources :workers

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  
  get '/auth/facebook/callback' => 'sessions#create'

  root 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
