Rails.application.routes.draw do
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
    # path: '',
    # path_names: {
    #   sign_up: '',
    #   sign_in: 'login',
    #   sign_out: 'logout',
    #   registration: "signup",
    # },
    # controllers: {
    #   sessions:      'customers/sessions',
    #   passwords:     'customers/passwords',
    #   registrations: 'customers/registrations'
    # }

  # ========= ユーザー(public)のルーティング ================
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'

    resources :products, only: [:index, :show]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]

    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'

    resources :orders, only: [:index, :show, :new]

    resources :carts, only: [:index, :create, :update]
    delete 'carts/destroy_all' => 'carts#destroy_all'
    delete 'carts/:id' => 'carts#destroy', as: 'destroy_cart'

    put 'my_page' => 'customers#update', as: 'customer'
    get 'my_page/edit' => 'customers#edit', as: 'edit_customers'
    get 'customers/my_page' => 'customers#show', as: 'customer_show'
    get 'customers/quit_confirm' => 'customers#quit_confirm'
    patch 'customers/quit' => 'customers#quit'
  end

  # ========= 管理者(admin)のルーティング ================
  devise_for :admins
  
    
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :products, only: [:index, :show, :new, :create, :edit, :update]
    resources :orders, only: [:show, :update] 
    resources :order_products, only: [:update]
    get '/' => 'orders#top', as: 'top'
  end

end

