Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      # User routes
      resources :users, only: [:create, :show, :update]

      # Contact routes
      resources :contacts, only: [:index, :create, :update, :destroy] do
        member do
          post 'mark_as_spam' # Mark a specific contact as spam
        end
      end
      
      get 'search', to: 'contacts#search' # Search contacts by name or phone number
    end
  end
end
