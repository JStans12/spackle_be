Rails.application.routes.draw do

 root 'welcome#welcome'

  namespace :api do
    namespace :v1 do
      get '/page', to: 'pages#show'
      get '/me', to: 'users#me'

      post '/login', to: 'sessions#create'

      resources :users, only: [:create] do
        get '/confirm_email', to: 'users#confirm_email'

        resources :ups, only: [:create]
        resources :comments, only: [:create, :update, :destroy], param: :comment_id
      end
    end
  end
end
