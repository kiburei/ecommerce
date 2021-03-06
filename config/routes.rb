Rails.application.routes.draw do
  resources :addresses
  resources :categories
  resources :products
  resources :order_items
  resources :orders
  devise_for :shops, controllers: { registrations: "registrations" }
  root 'home#index'
  get '/add_to_cart' => 'shopping_cart#add_to_cart', as: :add_to_cart
  get '/removeItem/:order_item_id' => 'shopping_cart#remove_from_cart', as: :remove_from_cart
  get '/addItem/:order_item_id' => 'shopping_cart#add_item', as: :add_item
  get '/minusItem/:order_item_id' => 'shopping_cart#minus_item', as: :minus_item
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
