Rails.application.routes.draw do
  devise_for :users
  root "movies#index"

  namespace :api do
    resources :movies
  end

  resources :movies do
    member do
      patch '/rate/:rate', to: 'movies#rate'
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
  end
end
