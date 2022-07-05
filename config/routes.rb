Rails.application.routes.draw do


  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    passwords:     'public/passwords',
    registrations: 'public/registrations'
  }

  scope module: :public do
    root to: 'homes#top'
    get "/about" => "homes#about", as: "about"
    get 'customers/mypage', :to => "customers#show", as: "customers"
    get 'customers/mypage/edit', :to => "customers#edit", as: "edit_customers"
    patch 'customers/mypage', :to => "customers#update"
    get 'customers/mypage/confirm', :to => "customers#confirm"
    patch 'customers/mypage/unsubscribe', :to => "customers#unsubscribe"
    resources :addresses, only: [:index, :edit, :destroy, :update, :create]
    resources :items, only: [:index, :show]
    delete '/cart_items/destroy_all', :to => "cart_items#destroy_all"
    resources :cart_items, only: [:index, :update, :destroy, :create]
    get "orders/completion"=> "orders#completion"
    resources :orders, only: [:index, :show, :index, :create, :new]
    post "orders/confirm" => "orders#confirm"


  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {

  sessions: "admin/sessions"
  }

  namespace :admin do
    get '/', :to => "homes#top"
    resources :genres, only: [:create, :edit, :index, :update]
    resources :items, only: [:create, :edit, :index, :update, :new, :show]
    resources :customers, only: [:edit, :index, :update, :show]
    resources :orders, only: [:show, :update]
    patch 'ordered_products/:id', :to => "ordered_products#update", as: "update_ordereb"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
