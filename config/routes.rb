Rails.application.routes.draw do
  devise_for :merchants
  root 'home#index'
  resources :product_models, only: %i[new create show]
  resources :categories, only: %i[index new create]
end
