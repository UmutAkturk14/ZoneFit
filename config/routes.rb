Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


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
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit], path: 'profiles', as: 'user_profiles'
end
