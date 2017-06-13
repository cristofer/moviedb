Rails.application.routes.draw do
  devise_for :users
  root "movies#index"

  resources :movies do
    member do
      patch '/rate/:rate', to: 'movies#rate'
    end
  end
end
