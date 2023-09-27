Rails.application.routes.draw do

    #顧客
  # URL /customers/sign_in ...
  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  root to: "public/homes#top"
  get 'about' => 'public/homes#about'

  get '/genre/search' => 'searches#genre_search'

  scope module: :public do
    get "customers/my_page" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
    resources :addresses, only: [:index, :create, :destroy, :edit, :update]
    #退会確認画面
    get '/customers/confirm' => 'customers#confirm'
    #退会処理
    patch '/customers/withdrawal' => 'customers#withdrawal'
  end

  scope module: :public do
    resources :items, only: [:index, :show]
  end

  scope module: :public do
    resources :cart_items, only: [:index, :create, :update, :destroy]
  end

  delete 'cart_items/destroy_all' => 'public/cart_items#destroy_all'

  scope module: :public do
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'
    resources :orders, only: [:new, :create, :index, :show]
  end


  # 管理者
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

    get 'admin' => 'admin/homes#top'

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end

    namespace :admin do
    resources :orders, only: [:show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
