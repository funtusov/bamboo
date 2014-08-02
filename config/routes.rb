Bamboo::Application.routes.draw do
  devise_for :user

  namespace :api do
    resources :users, only: [:show, :update]
    resources :products, only: [:index, :show]
    resources :carts, only: [:show]
    resources :line_items, only: [:create]
  end

  get "*route", to: "application#index"
  root 'application#index'
end