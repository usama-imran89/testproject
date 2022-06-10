Rails.application.routes.draw do
  get 'categories_items/index'
  #get 'categories/index'
  #get 'category/index'
  #get 'items/index'
  root 'home#index'
  devise_for :users
  resources :categories do
    resources :items
  end
  post "categories/:category_id/items/:id", to: 'categories#add_to_cart', as: 'add_to_cart'
  delete "categories/:category_id/items/:id", to: 'categories#remove_from_cart', as: 'remove_from_cart'

  #resources :items
  resources :categories_items

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
