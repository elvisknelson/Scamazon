Rails.application.routes.draw do
  get 'cart/index'
  get 'search/index'

  post 'product/add_to_cart/:id', to: 'product#add_to_cart', as: 'add_to_cart'
  delete 'product/remove_from_cart/:id', to: 'product#remove_from_cart', as: 'remove_from_cart'

  get 'category/index'
  resources 'category', only: %i[index show]

  root to: 'product#index'
  resources 'product', only: %i[index show]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
