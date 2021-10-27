Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "login", to: "sessions#new" # ログインページのURL設定
  post "login", to: "sessions#create" # ログインページのURL設定
  delete "logout", to: "sessions#destroy" 
  
  get "signup", to: "users#new" # ユーザ登録のURLをsignupにする
  resources :users, only: [:index, :show, :create] do # ユーザの一覧ページ、詳細ページ、ユーザ登録はOKだが、編集やアカウント削除はできない。
    member do # フォロー中のユーザと、フォロワーの一覧を表示するページ
      get :followings
      get :followers
    end
  end
  
  resources :microposts, only: [:create, :destroy] # Micropostは新規投稿と削除のみ
  resources :relationships, only: [:create, :destroy] # ユーザをフォロー＆アンフォローするルーティング
end