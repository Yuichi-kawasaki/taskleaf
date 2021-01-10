Rails.application.routes.draw do
  root to: 'tasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks do
      collection do
        post :confirm
  end
end
end
