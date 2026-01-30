Rails.application.routes.draw do
  get "projects/index"
  get "projects/show"
  get "posts/index"
  get "posts/show"
  get "pages/home"
  get "pages/experiences"
  get "pages/about"
  # Public Routes
  root "pages#home"
  
  resources :posts, only: [:index, :show]
  resources :projects, only: [:index, :show]
  get "experiences", to: "pages#experiences"
  get "about", to: "pages#about"

  # Admin Namespace (Restricted to you)
  namespace :admin do
  root "dashboard#index"
  # Add except: [:show] here
  resources :posts, param: :slug, except: [:show]
  resources :projects, param: :slug, except: [:show]
  resources :contacts, only: [:create]
  end

  # Login Routes
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end