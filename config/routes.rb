Rails.application.routes.draw do
  devise_for :merchants
  root 'home#index'
  resources :categories, only: %i[index new create edit update show] do
    patch 'disable', on: :member
    patch 'enable', on: :member
    resources :sub_categories, only: %i[show new create] do
      patch 'disable', on: :member
      patch 'enable', on: :member
    end
  end

  resources :product_models, only: %i[new create show index] do
    patch 'disable', on: :member
    patch 'enable', on: :member
    resources :product_prices, only: %i[new create edit update]
  end
end
