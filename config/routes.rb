Rails.application.routes.draw do
  scope module: :public do
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete'
    resources :orders, only: [:new, :create, :index, :show]
  end

  root to: "public/homes#top"
  get 'about' => 'public/homes#about'

  #顧客
  # URL /customers/sign_in ...
  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  # 管理者
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
