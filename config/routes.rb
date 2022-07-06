# frozen_string_literal: true

Rails.application.routes.draw do
  root 'categories#index'
  devise_for :users
  # patch '/items/:id', to: 'items#update'
  resources :categories do
    resources :items, except: %i[edit], shallow: true do
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
  get '/categories/:category_id/items/:id', to: 'items#edit', as: 'edit_item'
  resources :orders, except: %i[destroy] do
    collection do
      get 'pending', to: 'orders#order_status'
      get 'delivered', to: 'orders#order_status'
      get 'cancelled', to: 'orders#order_status'
    end
  end
  resources :carts, only: %i[index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
