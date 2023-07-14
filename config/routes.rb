Rails.application.routes.draw do

  root to: "pages#landing"
  devise_for :users
  get 'home', to: 'pages#home', as: 'home'


  # Route for a `Friends` page
  get 'friends', to: 'pages#friends', as: 'friends'

  get 'search', to: 'pages#search', as: 'search'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # Routes for Watchlist/Favourite/Cookbook stuff
  post "recipes/:id/cookbook", to: "recipes#cookbook", as: "cookbook"
  post "workout/:id/watchlist", to: "workouts#watchlist", as: "watchlist_workout"
  post "workout/:id/favorite", to: "workouts#favorite", as: "favorite_workout"

  # Route for messaging
  post "profiles/:id/message", to: "profiles#message", as: "message_profile"

  # Routes for friendship stuff
  post "profiles/:id/friend", to: "profiles#friend", as: "friend"
  post "profiles/:id/unfriend", to: "profiles#unfriend", as: "unfriend"
  post "profiles/:id/accept", to: "profiles#accept", as: "accept"
  post "profiles/:id/decline", to: "profiles#decline", as: "decline"
  post "profiles/:id/cancel", to: "profiles#cancel", as: "cancel"

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

  # Can comment this out if messages and communities are going to be in the same page
  resources :private_chatrooms, only: [:index, :show] do
    resources :private_messages, only: :create
  end
end
