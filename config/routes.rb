Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'articles#index'
  resources :articles do
    resources :comments 
    # 瀏覽所有餐廳的最新動態
    collection do
      get :feeds
    end
    member do
      # 其他程式碼
      post :favorite
      post :unfavorite
    end
  end
  resources :users do
    member do
      get :posts
      get :comments
      get :collects
      get :drafts
      get :friends
    end
  end
  resources :friendships, only: :create do
    member do 
      post :accept
      delete :ignore
    end
  end
  resources :categories   # 請加入此行
  namespace :admin do
    resources :users, only: [:index, :update]
    resources :articles
    resources :categories   # 請加入此行
    root 'articles#index'
  end
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      
      post "/login" => "auth#login"
      post "/logout" => "auth#logout"

      resources :posts, only: [:index, :create, :show, :update, :destroy]
    end
  end
end
