class ToppagesController < ApplicationController
  def index
    if logged_in?
      @micropost = current_user.microposts.build # form_with 用
      @pagy, @microposts = pagy(current_user.microposts.order(id: :desc)) # ページネーションを使用した一覧表示
    end
  end
end
