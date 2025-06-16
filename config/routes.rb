Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :lists do
    # it's a nested resource because bookmarks belong to lists
    # this means that the URL will be /lists/:list_id/bookmarks/new
    resources :bookmarks, only: [:new, :create]
  end
  # destroy is not nested because we want to be able to delete bookmarks without needing to know the list they belong to
  resources :bookmarks, only: [:destroy]

  resources :movies, only: [:destroy]
end
