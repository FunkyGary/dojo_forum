Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'articles#index'
  resources :articles
  resources :categories   # 請加入此行
  namespace :admin do
    resources :articles
    resources :categories   # 請加入此行
    root 'articles#index'
  end
end
