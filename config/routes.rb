Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :addresses
  resources :categories
  resources :products
  resources :order_items
  resources :orders
  resources :wishlist
  devise_for :shops, controllers: { registrations: "registrations" }
  root 'home#index'
  get '/add_to_cart' => 'shopping_cart#add_to_cart', as: :add_to_cart
  get '/removeItem/:order_item_id' => 'shopping_cart#remove_from_cart', as: :remove_from_cart
  get '/addItem/:order_item_id' => 'shopping_cart#add_item', as: :add_item
  get '/minusItem/:order_item_id' => 'shopping_cart#minus_item', as: :minus_item
  get 'payment', to: 'orders#payment'
  get 'confirmations', to: 'orders#confirmations'
  get '/wishlist/' =>'wishlist#wishlist'
  get '/remove_from_list/' => 'wishlist#remove_from_wishlist', as: :remove_from_list
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
