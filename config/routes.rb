Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/comments', to: 'comments#index'

      get '/login', to: 'sessions#new'
    end
  end
end
