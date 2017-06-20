Rails.application.routes.draw do
  devise_for :users
  root "movies#index"

  namespace :api do
    namespace :v2 do
      mount API::V2::Movies, at: "/movies/"
    end

    resources :movies
  end

  resources :movies do
    member do
      patch '/rate/:rate', to: 'movies#rate'
    end

    member do
      get '/rate_by_amount/:id', to: 'movies#rate_by_amount', as: 'rate_by_amount'
    end

    collection do
      post :search
    end

    collection do
      get :search_by_category
    end

    collection do
      get :search_by_rate
    end

    resources :comments, only: [:create]
  end
end
