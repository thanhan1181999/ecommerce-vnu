Rails.application.routes.draw do
  scope :api do
    devise_for :users, as: :api, defaults: { format: :json }
  end

  namespace :api do
    get 'product/index'
    get 'product/create'
    get 'product/update'
    get 'product/destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do  
    namespace :admin do
      resources :users
    end
    resources :categorys, only: [:index, :create, :destroy, :update]
    resources :products, only: [:index, :create, :destroy, :update]

    # orders handle
    namespace :user do
      get 'orders', to: 'orders#index'
      post 'orders', to: 'orders#create'
      patch 'orders/cancel', to: 'orders#cancel'
      get 'orders/filter', to: 'orders#filter'

      # cart
      post 'carts', to: 'carts#create'
      get 'carts', to: 'carts#index'
      delete 'carts', to: 'carts#destroy'
      get 'carts/filter', to: 'carts#filter'
      patch 'carts', to: 'carts#update'
    end

    namespace :store do
      get 'orders', to: 'orders#index'
      patch 'orders/accept', to: 'orders#accept'
      patch 'orders/cancel', to: 'orders#cancel'
      get 'orders/filter', to: 'orders#filter'
      post '/', to: 'stores#create'
      delete '/', to: 'stores#destroy'
    end
  end
  
end
