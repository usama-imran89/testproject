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
  #resources :items
  resources :categories_items
  #post "/items" , to:"items#create"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
