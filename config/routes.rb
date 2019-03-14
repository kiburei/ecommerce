Rails.application.routes.draw do
  resources :addresses
  devise_for :shops, controllers: { registrations: "registrations" }
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
