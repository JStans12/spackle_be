Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/page', to: 'pages#show'

      post '/login', to: 'sessions#create'

      get '/me', to: 'users#me'

      resources :users, only: [:create] do
        get '/confirm_email', to: 'users#confirm_email'
        post '/ups',           to: 'ups#create'

        resources :comments, only: [:create, :update, :destroy]
      end
    end
  end
end
