Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "login", to: "sessions#new" # ログインページのURL設定
  post "login", to: "sessions#create" # ログインページのURL設定
  delete "logout", to: "sessions#destroy" 
  
  get "signup", to: "users#new" # ユーザ登録のURLをsignupにする
  resources :users, only: [:index, :show, :new, :create] # ユーザの一覧ページ、詳細ページ、ユーザ登録はOKだが、編集やアカウント削除はできない。
end
