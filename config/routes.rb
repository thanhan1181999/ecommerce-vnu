Rails.application.routes.draw do
  scope :api do
    devise_for :users, as: :api, defaults: { format: :json }, controllers: { sessions: 'api/authen/sessions',
                                                                             registrations: 'api/authen/registrations' }
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    get '/home', to: 'products#home'

    namespace :admin do
      resources :users
    end
    resources :categorys, only: %i[index create destroy update]
    resources :products, only: %i[index create destroy update show]

    namespace :user do
      # orders handle
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
      put 'carts/:id', to: 'carts#update1'

      # sale
      get 'sales', to: 'sales#index'
      get 'sale/:id', to: 'sales#show'
      # comments
      post 'comments', to: 'comments#create'
      get 'comments/:id', to: 'comments#show'
      delete 'comments', to: 'comments#destroy'

      # profile handler
      get '/profile', to: 'profile#profile'
      patch '/profile', to: 'profile#update'
    end

    namespace :store do
      get 'orders', to: 'orders#index'
      patch 'orders/accept', to: 'orders#accept'
      patch 'orders/cancel', to: 'orders#cancel'
      get 'orders/filter', to: 'orders#filter'

      post '/', to: 'stores#create'
      delete '/', to: 'stores#destroy'
      put '/', to: 'stores#update'
      get '/', to: 'stores#current_store'

      get '/:id', to: 'stores#show'

      get 'products/getAll', to: 'stores#products'

      # sale
      get 'sales', to: 'sales#index'
      post 'sales', to: 'sales#create'
      delete 'sale/:id', to: 'sales#destroy'
      patch 'sale/:id', to: 'sales#update'
      get 'sale/:id', to: 'sales#show'
    end
  end
end
