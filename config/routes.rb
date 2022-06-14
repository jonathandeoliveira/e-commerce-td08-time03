Rails.application.routes.draw do
  devise_for :merchants
  root 'home#index'
  resources :product_models, only: %i[new create show]
  resources :categories, only: %i[index new create edit update] do
    patch 'disable', on: :member
    patch 'enable', on: :member
  end
end
