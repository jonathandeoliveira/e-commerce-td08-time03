Rails.application.routes.draw do
  devise_for :merchants
  root 'home#index'
end
