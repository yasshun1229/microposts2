Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "signup", to: "users#new" # ユーザ登録のURLをsignupにする
  resources :users, only: [:index, :show, :create] # ユーザの一覧ページ、詳細ページ、ユーザ登録はOKだが、編集やアカウント削除はできない。# ユーザ登録ページは、トップページから登録するため、いらない。
end
