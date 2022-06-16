Rails.application.routes.draw do
  devise_for :merchants
  root 'home#index'
  resources :categories, only: %i[index new create edit update] do
    patch 'disable', on: :member
    patch 'enable', on: :member
  end
  resources :product_models, only: %i[new create show index] do
    patch 'disable', on: :member
    patch 'enable', on: :member
    resources :product_prices, only: %i[new create]
  end
end
