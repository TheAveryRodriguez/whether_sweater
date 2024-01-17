Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v0 do
      # resources :forecasts, only: [:index]
      get "/forecast", to: "forecasts#index"
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      # resources :road_trips, only: [:create]
      post "/road_trip", to: "road_trips#create"
    end
  end
end
