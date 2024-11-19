Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  resources :products, only: [ :index, :show ]
  resources :orders, only: [ :new, :create, :show ]

  get "cart", to: "cart#show"
  post "cart/:product_id", to: "cart#create", as: "add_to_cart"
  post "update_cart", to: "cart#update", as: "update_cart"
  delete "remove_from_cart/:product_id", to: "cart#remove", as: "remove_from_cart"

  get "contact", to: "pages#contact"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
