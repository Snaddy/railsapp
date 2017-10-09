  Rails.application.routes.draw do
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
      post 'registrations' => 'registrations#create'
      put 'update' => 'registrations#update'
      post 'sessions' => 'sessions#create'
      delete 'sessions' => 'sessions#destroy'
      get :following, :followers
    end

    get 'posts' => 'posts#index'

    get 'post/:id' => 'posts#show'

    post 'posts' => 'posts#create'

    post 'post/:post_id/comments/:content' => 'comments#create'

    delete 'comments/:id' => 'comments#destroy'

    delete 'post/:id/comment/:id' => 'posts#destroy_comment'

    get 'search/:search' => 'pages#search', :constraints => { :search => /.*/ }

    get 'username/:username_search' => 'searches#username_search', :constraints => { :username_search => /.*/ }

    get 'email/:email_search' => 'searches#email_search', :constraints => { :email_search => /.*/ }

    get 'profile' => 'pages#self'

    match 'like/:id', to: 'likes#like', via: :post

    match 'unlike/:id', to: 'likes#unlike', via: :delete

    match 'relationships/:id', to: 'relationships#create', via: :post

    match 'relationships/:id', to: 'relationships#destroy', via: :delete

    match 'users/:id', to: 'pages#profile', via: :get
    
    post 'account/reset_password/:email' => 'accounts#reset_password', :constraints => { :email => /.*/ }

  end
  end
end
