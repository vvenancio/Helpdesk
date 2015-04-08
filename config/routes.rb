Aszist::Application.routes.draw do

  resources :services

  resources :contract_types

  resources :contracts

  resources :enterprises

  devise_for :users

  resources :tickets do
    resources :comments
  end

  resources :users, except: [ :show ] do
    collection do
      post 'manage'
    end
  end

  get "/profile", to: "profiles#edit", as: :edit_profile
  patch "/profile", to: "profiles#update"

  root :to => 'tickets#index'

end