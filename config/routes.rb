# frozen_string_literal: true

Rails.application.routes.draw do
  root 'categories#index'
  devise_for :users
  resources :categories do
    resources :items do
      member do
        post 'retire'
        post 'resume'
        post 'increase_item_qty'
        post 'decrease_item_qty'
        post 'add_to_cart'
        delete 'remove_from_cart'
      end
    end
  end
  resources :orders, except: %i[destroy] do
    collection do
      get 'pending'
      get 'delivered'
      get 'canceled'
    end
  end
 # resources :items, only: %i[show]
  resources :carts, only: %i[index]
  # delete "categories/:category_id/items/:id", to: 'items#remove_from_cart', as: 'remove_from_cart'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
