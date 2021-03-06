class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  # newアクション及びcreateアクションは、通常のユーザー作成機能を実装時に有効化。

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
      if @user
        redirect_back_or_to root_path, success: 'ログインしました'
      else
        flash.now[:danger] = 'ログインに失敗しました'
        render :new
      end
  end

  def destroy
    logout
    redirect_to root_path
    flash[:success] = t 'users.flash.logout'
  end
end
