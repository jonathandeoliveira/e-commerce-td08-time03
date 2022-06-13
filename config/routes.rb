Rails.application.routes.draw do
  devise_for :merchants
  root 'home#index'
  resources :product_models, only: [:new, :create, :show, :index] do
    patch 'disabled', on: :member
    patch 'enabled', on: :member
  end
end