Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/comments', to: 'comments#index'

      post '/login', to: 'sessions#create'

      get '/me', to: 'users#me'
    end
  end
end
