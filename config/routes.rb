Rails.application.routes.draw do
  #get 'categories/index'
  #get 'category/index'
  get 'items/index'
  root 'home#index'
  devise_for :users
  resources :items
  resources :categories
  resources :categories_items
  post "/items" , to:"items#create"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
