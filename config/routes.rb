Rails.application.routes.draw do
  resources :carts
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'categories#index'
  devise_for :users
  resources :categories do
    resources :items do
      member do
        post "increase_item_qty"
        post "decrease_item_qty"
        post "add_to_cart"
        delete "remove_from_cart"
      end
    end
  end
resources :orders do
  collection do
    get "history", to: "orders#history"
  end

end
  resources :orders do
    resources :items
  end

  #post "categories/:category_id/items/:id", to: 'carts#add_to_cart', as: 'add_to_cart'
  #post "categories/:category_id/items/:id", to: 'items#increase_item_qty', as: 'increase_item_qty'
  #delete "categories/:category_id/items/:id", to: 'items#remove_from_cart', as: 'remove_from_cart'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
