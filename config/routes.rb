Rails.application.routes.draw do
  scope module: :public do
    get "customers/my_page" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
  end
  root to: "public/homes#top"
  get 'about' => 'public/homes#about'

  #顧客
  # URL /customers/sign_in ...
  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  #退会確認画面
  get '/customers/confirm' => 'customers#confirm'
  #退会処理
  patch '/customers/withdrawal' => 'customers#withdrawal'


  get 'items' => 'public/items#index'
  get 'items/:id' => 'public/items#show'


  # 管理者
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
