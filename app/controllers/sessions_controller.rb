class SessionsController < ApplicationController
  def new # ログインのnewアクションの処理はいらない
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = "ログイン成功しました"
      redirect_to @user
    else
      flash.now[:danger] = "ログイン失敗しました"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました"
    redirect_to root_url # リダイレクト時は必ず〇〇_url
  end
  
  private
  
  def login(email, password)
    @user = User.find_by(email, password)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end 
  end
end
