Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/start", to: "pages#start"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :apartments, only: %i[index create]
  resources :meals, only: %i[index create]
  resources :car, only: %i[new create]
  resources :mobile, only: %i[new create]
  resources :health, only: %i[new create]
  resources :clothing, only: %i[new create]
  resources :beauty, only: %i[new create]
  resources :kid, only: %i[new create]
  resources :entertainment, only: %i[new create]
  resources :other, only: %i[new create]
  resources :repayment, only: %i[new create]
  resources :saving, only: %i[new create]
  # Defines the root path route ("/")
  # root "articles#index"
end
