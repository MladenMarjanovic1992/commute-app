Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  get 'drivers/show'

  get 'rides/show'
  
  get 'dashboards/index'
  
  get 'dashboards/search'

  devise_for :users
  root to: 'dashboards#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do 
    resources :rides
  end
  resources :users do 
    resources :cars, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :dashboards, only: [:index] do
    collection do
      get :search, to: "dashboards#search", as: 'search_rides'
    end
  end
  
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
    end
    collection do
      delete :empty_trash
    end
  end
  
  resources :messages, only: [:new, :create]
  
end
