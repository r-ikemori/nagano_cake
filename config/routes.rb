Rails.application.routes.draw do
  devise_for :customers,skip: [:registrations, :passwords], controllers: {
    sessions: 'public/sessions'
  }
  devise_scope :customers do
    get '/customers/sign_up', to: 'public/registrations#new'
    post '/customers', to: 'public/registrations#create'
  end
  scope module: :public do
    root to: 'homes#top'
    get "/about" => "homes#about", as: "about"
    resource :customers, only: [:show, :edit, :destroy, :update, :confirm]
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {

  sessions: "admin/sessions"
  }

  namespace :admin do
    resources :genres, only: [:create, :edit, :index, :update]
    resources :items, only: [:create, :edit, :index, :update, :new, :show]
    resources :customers, only: [:edit, :index, :update, :show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
