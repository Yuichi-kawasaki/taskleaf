Rails.application.routes.draw do
  resources :labels
  root to: "tasks#index"
  # resources :users, only: [:new, :create, :show]
  namespace :admin do
    resources :users, only: [:index, :new, :create, :show, :edit, :destroy, :update]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks do
    collection do
      post :confirm

      resources :users, only: [:new, :create, :show]
    end
  end
end
