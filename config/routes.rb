Rails.application.routes.draw do
  devise_for :customers
  devise_for :merchants
  root 'home#index'

  resources :categories, only: %i[index new create edit update show] do
    patch 'disable', on: :member
    patch 'enable', on: :member
    resources :sub_categories, only: %i[show new create] do
      get 'search', on: :collection
      patch 'disable', on: :member
      patch 'enable', on: :member
    end
  end

  resources :product_models, only: %i[new create show index] do
    get 'product-detail', on: :member
    get 'search', on: :collection
    patch 'disable', on: :member
    patch 'enable', on: :member
    resources :product_prices, only: %i[new create edit update]
  end

  resources :customers do 
    get 'rubi_buy', to: 'customers#rubi_buy'
    post 'rubi_buy', to: 'customers#send_credit_request'
    get 'order_with_coupon', to: 'orders#order_with_coupon'
    post 'order_with_coupon', to: 'orders#send_cupom_params'
    resources :orders, only: %i[new create index show] do
      patch 'search-coupon', on: :collection 
    end

    get 'account', on: :member
    resources :product_items, only: %i[index new create destroy] do
      patch 'sum_quantity', on: :member
      patch 'reduce_quantity', on: :member
      delete 'remove_all', on: :collection
    end
  end

  resources :promotions, only: %i[index new create show]

  get 'merchant-order-index', to: 'orders#merchant_index'
  get 'merchant-order-show/:id', to: 'orders#merchant_show', as: :merchant_order

  namespace :api do
    namespace :v1 do
      scope :orders do
        patch 'update_status', to: 'orders#update_status'
      end
    end
  end
end
