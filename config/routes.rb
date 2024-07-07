Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "home#index"

  get 'home/index'

  # This allows dynamically fetching islands.
  get '/islands/:id', to: 'islands#show'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
