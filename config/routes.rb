Rails.application.routes.draw do
  devise_for :users
  root "movies#index"

  resources :movies do
    member do
      patch '/rate/:rate', to: 'movies#rate'
    end

    collection do
      post :search
    end
  end
end
