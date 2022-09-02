Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/merchants/find", to: 'find#find_one_merchant'
      get "/items/find_all", to: 'find#find_all_items'

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
      end

      resources :items, only: [:index, :show, :create, :update, :destroy]

      get "/items/:id/merchant", to: 'merchant_items#show'
    end
  end
end
