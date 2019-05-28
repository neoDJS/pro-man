Rails.application.routes.draw do

  resources :projects, param: :slug do
    resources :todos do
      # resources :user_todos, only: [:new, :create]
      get '/affectation/new' => 'todos#addWorker'
      post '/affectation' => 'todos#affectation'
    end
  end

  resources :users do #, only: [:new, :create, :edit, :update, :show]
    resources :workers, only: [:new]
  end
  resources :workers

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  
  get '/auth/facebook/callback' => 'sessions#create'

  root 'welcome#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
