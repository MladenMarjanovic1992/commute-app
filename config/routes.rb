Rails.application.routes.draw do
  get 'rides/index'

  get 'rides/show'

  get 'rides/create'

  get 'rides/edit'

  get 'rides/update'

  get 'rides/destroy'

  devise_for :users
  get 'dashboards/index', to: 'dashboards#index'
  root 'dashboards#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do 
    resources :rides
  end
end
