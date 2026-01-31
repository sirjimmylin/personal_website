Rails.application.routes.draw do
  # Public Routes
  root "pages#home"
  get "search", to: "search#index"
  resources :posts, only: [:index, :show]
  resources :projects, only: [:index, :show]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # --- ADD THIS LINE ---
  resources :contacts, only: [:create]
  # ---------------------

  get "experiences", to: "pages#experiences"
  get "about", to: "pages#about"

  # Admin Namespace
  namespace :admin do
    root "dashboard#index"
    resources :posts, param: :slug, except: [:show]
    resources :projects, param: :slug, except: [:show]
    
    # --- ADD THIS ---
    resources :contacts, only: [:index, :destroy]
  end

  # Login Routes
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end