Rails.application.routes.draw do

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end

  scope '/product' do
    post 'add_to_cart/:id', to: 'product#add_to_cart', as: 'add_to_cart'
    post 'update_cart/:id', to: 'product#update_cart', as: 'update_cart'
    delete 'remove_from_cart/:id', to: 'product#remove_from_cart', as: 'remove_from_cart'
  end

  get 'cart/index'
  get 'search/index'
  get 'account/index'

  get 'about', to: 'about_us#index'
  get 'contact', to: 'about_us#contact'

  get 'category/index'
  resources 'category', only: %i[index show]

  post 'sign_up', to: 'account#sign_up', as: 'account_sign_up'
  post 'sign_in', to: 'account#sign_in', as: 'account_sign_in'
  get 'sign_in', to: 'account#sign_in'
  resource 'sign_out', to: 'account#sign_out', as: 'account_sign_out'

  root to: 'product#index'
  get 'sale', to: 'product#sale', as: 'product_sale'
  get 'rating', to: 'product#rating', as: 'product_rating'
  get 'new', to: 'product#new', as: 'product_new'
  resources 'product', only: %i[index show]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
