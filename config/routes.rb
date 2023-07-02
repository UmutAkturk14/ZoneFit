Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post "recipes/:id/cookbook", to: "recipes#cookbook", as: "cookbook"
  post "workout/:id/watchlist", to: "workouts#watchlist", as: "watchlist_workout"
  post "workout/:id/favorite", to: "workouts#favorite", as: "favorite_workout"

  resources :workouts, only: [:index, :show, :new, :create] do
    resources :comments, only: [:create, :destroy]
  end

  resources :recipes, only: [:index, :show, :create, :new, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
    collection do
      get :search_ingredients
    end
  end
  resources :posts, only: [:index, :new, :create, :destroy] do
    resources :comments, only: [:create]
  end
  resources :comments, only: :destroy
  resources :users, only: [:show, :edit, :update], path: 'profiles', as: 'user_profiles'

  resources :chatrooms, only: [:show, :index, :create, :destroy] do
    resources :messages, only: :create
  end
end
