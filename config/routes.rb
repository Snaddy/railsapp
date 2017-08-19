Rails.application.routes.draw do
  resources :relationships, only: [:create, :destro
  get 'user/:id' => "pages#profile"
  match 'like', to: 'likes#like', via: :post
  match 'unlike', to: 'likes#unlike', via: :delete
  devise_for :users
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
      post 'registrations' => 'registrations#create', :as => 'register'
      put 'update' => 'registrations#update', :as => 'update_user'
      post 'sessions' => 'sessions#create', :as => 'login'
      delete 'sessions' => 'sessions#destroy', :as => 'logout'
    end
    get 'posts' => 'posts#index', :as => 'posts_all'
    post 'posts' => 'posts#create', :as => 'create_post'

    get 'search/:search' => 'pages#search', :as => 'search'

    get 'username/:username_search' => 'pages#username_search', :as => 'username_search', :constraints => { :username_search => /.*/ }

    get 'email/:email_search' => 'pages#email_search', :as => 'email_search', :constraints => { :email_search => /.*/ }

    get 'profile' => 'pages#self', :as => 'self'

    match 'like/:id', to: 'likes#like', via: :post

    match 'unlike/:id', to: 'likes#unlike', via: :delete

    match 'relationships/:id', to: 'relationships#create', via: :post

    match 'relationships/:id', to: 'relationships#destroy', via: :delete

    match 'users/:id', to: 'pages#profile', via: :get

  end
  end
end
