Rails.application.routes.draw do
  scope module: :public do
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'
    resources :orders, only: [:new, :create, :index, :show]
  end

  root to: "public/homes#top"
  get 'about' => 'public/homes#about'

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

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end
  #顧客
  # URL /customers/sign_in ...
  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}



  get 'items' => 'public/items#index'
  get 'items/:id' => 'public/items#show'

  scope module: :public do
    resources :cart_items, only: [:index, :create, :update, :destroy]
  end

  delete 'cart_items/destroy_all' => 'public/cart_items#desstroy_all'

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end
  # 管理者
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
