Rails.application.routes.draw do
  devise_for :merchants
  root 'home#index'
  resources :product_models, only: [:new, :create, :show]
end
