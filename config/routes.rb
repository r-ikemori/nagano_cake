Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins
    namespace :admin do
    resources :genres, only: [:create, :edit, :index, :update]
    resources :items, only: [:create, :edit, :index, :update, :new, :show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
