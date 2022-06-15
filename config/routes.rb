Rails.application.routes.draw do
  devise_for :merchants
  root 'home#index'
  resources :product_models, only: [:new, :create, :show, :index] do
    patch 'disable', on: :member
    patch 'enable', on: :member
  end
  resources :categories, only: %i[index new create]
end
