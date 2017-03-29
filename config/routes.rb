Rails.application.routes.draw do

  get 'drivers/show'

  get 'rides/index'

  get 'rides/show'

  devise_for :users
  get 'dashboards/index', to: 'dashboards#index'
  root 'dashboards#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do 
    resources :rides
  end
  resources :users do 
    resources :cars, only: [:new, :create, :edit, :update, :destroy]
  end
end
