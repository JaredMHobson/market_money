Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  #
  namespace :api do
    namespace :v0 do
      get '/markets/search', to: 'markets#search'
      get '/markets/:id/nearest_atms', to: 'markets#nearest_atms'
      resources :markets, only: [:index, :show]
      resources :vendors, only: [:create, :destroy, :show, :update]
      get '/markets/:id/vendors', to: 'market_vendors#index'
      resources :market_vendors, only: [:create, :destroy]
      delete '/market_vendors', to: 'market_vendors#destroy'
      post '/market_vendors', to: 'market_vendors#create'
    end
  end
end
