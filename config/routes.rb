Rails.application.routes.draw do
  root to: "tasks#index"
  resources :users, only: [:new, :create, :show]
    namespace :admin do
      resources :users, only: [:index, :new, :create, :show, :edit, :destroy, :update]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks do
    collection do
      post :confirm

    end
  end
end
