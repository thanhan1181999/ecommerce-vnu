Rails.application.routes.draw do
  namespace :api do
    get 'product/index'
    get 'product/create'
    get 'product/update'
    get 'product/destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do  
    resources :categorys
    resources :products
  end 
end
