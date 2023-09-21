Rails.application.routes.draw do
  root to: "public/homes#top"
  get 'about' => 'public/homes#about'
  
  #顧客
  # URL /customers/sign_in ...
  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  get "customers/my_page" => "customer#my_page"

  get 'items' => 'public/items#index'
  get 'items/:id' => 'public/items#show'
  
  scope module: :public do
    resources :cart_items, only: [:index, :create, :update, :destroy]
  end
  
  delete 'cart_items/destroy_all' => 'public/cart_items#desstroy_all'


  # 管理者
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
