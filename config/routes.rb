Rails.application.routes.draw do
  devise_for :users
  resources :posts
  root "posts#index"
  post '/create', to: 'subscriptions#create'

  resources :products
  resources :checkout, only: [:create]
  post "checkout/create", to: "checkout#create"
end
