Rails.application.routes.draw do

  resources :projects, param: :slug do
    resources :todos do
      # resources :user_todos, only: [:new, :create]
    end
  end

  resources :users, only: [:new, :create, :edit, :update, :show]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  root 'welcome#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
