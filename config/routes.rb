Rails.application.routes.draw do
  root 'home#index'
  resources :product_models, only: [:new, :create, :show]
end
