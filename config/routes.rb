Rails.application.routes.draw do
  resources :relationships, only: [:create, :destroy]
  get 'user/:id' => "pages#profile"
  match 'like', to: 'likes#like', via: :post
  match 'unlike', to: 'likes#unlike', via: :delete
  devise_for :users, controllers: { confirmations: 'confirmations'}
  resources :users do
    member do
      get :following, :followers
  end
end

#api
  namespace :api, defaults: { format: :json } do
  namespace :v1 do
    resources :posts
    devise_scope :user do
      post 'registrations' => 'registrations#create'
      put 'update' => 'registrations#update'
      post 'sessions' => 'sessions#create'
      delete 'sessions' => 'sessions#destroy'
    end
    get 'posts' => 'posts#index'

    post 'posts' => 'posts#create'

    post 'account/reset_password/:email' => 'accounts#reset_password', :constraints => { :email => /.*/ }

    get 'search/:search' => 'pages#search'

    get 'username/:username_search' => 'pages#username_search', :constraints => { :username_search => /.*/ }

    get 'email/:email_search' => 'pages#email_search', :constraints => { :email_search => /.*/ }

    get 'profile' => 'pages#self'

    match 'like/:id', to: 'likes#like', via: :post

    match 'unlike/:id', to: 'likes#unlike', via: :delete

    match 'relationships/:id', to: 'relationships#create', via: :post

    match 'relationships/:id', to: 'relationships#destroy', via: :delete

    match 'users/:id', to: 'pages#profile', via: :get

  end
  end
end
