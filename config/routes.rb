Rails.application.routes.draw do
  get 'items/index'
  root 'home#index'
  devise_for :users
  resources :items
  post "/items" , to:"items#create"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
