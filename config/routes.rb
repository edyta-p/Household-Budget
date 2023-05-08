Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/start", to: "pages#start"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :apartments, only: %i[index create] do
    collection do
      get :filter
    end
  end
  resources :meals, only: %i[index create] do
    collection do
      get :filter
    end
  end
  resources :cars, only: %i[index create] do
    collection do
      get :filter
    end
  end
  resources :mobiles, only: %i[index create] do
    collection do
      get :filter
    end
  end
  resources :healths, only: %i[index create] do
  collection do
    get :filter
  end
end
  resources :clothings, only: %i[index create] do
    collection do
      get :filter
    end
  end
  resources :cosmetics, only: %i[index create] do
    collection do
      get :filter
    end
  end
  resources :kids, only: %i[index create] do
    collection do
      get :filter
    end
  end
  resources :entertainments, only: %i[index create new show] do
    collection do
      get :filter
    end
  end
  resources :others, only: %i[index create] do
    collection do
      get :filter
    end
  end
  resources :repayments, only: %i[index create] do
    collection do
      get :filter
    end
  end
  resources :savings, only: %i[index create] do
    collection do
      get :filter
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
