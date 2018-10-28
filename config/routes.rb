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
  resources :categories   # 請加入此行
  namespace :admin do
    resources :articles
    resources :categories   # 請加入此行
    root 'articles#index'
  end
end
