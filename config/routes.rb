Bamboo::Application.routes.draw do
  devise_for :user
  
  namespace :api do
    # devise_for :user do
    # end

    resources :products
    resources :carts, only: [:show]
  end

  get "*route", to: "application#index"
  root 'application#index'
end