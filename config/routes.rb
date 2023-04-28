Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/start", to: "pages#start"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :apartments, only: %i[index create]
  resources :meals, only: %i[index create]
  resources :cars, only: %i[index create]
  resources :mobiles, only: %i[index create]
  resources :healths, only: %i[index create]
  resources :clothings, only: %i[index create]
  resources :cosmetics, only: %i[index create]
  resources :kids, only: %i[index create]
  resources :entertainments, only: %i[index create] do
    collection do
      get :search
    end
  end
  resources :others, only: %i[index create]
  resources :repayments, only: %i[index create]
  resources :savings, only: %i[index create]
  # Defines the root path route ("/")
  # root "articles#index"
end
