Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do  
    resources :categorys, only: [:index, :create, :destroy, :update]
    resources :products, only: [:index, :create, :destroy, :update]
  end
end
