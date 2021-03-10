class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :current_user?, only: [:edit, :destroy]

  # newアクション及びcreateアクションは、通常のユーザー作成機能を使用する場合のみ有効化。

  #  def new
  #    @user = User.new
  #  end

  #  def create
  #    @user = User.new(user_params)

  #    if @user.save
  #      flash[:success] = '新しいユーザーを登録しました。'
  #      redirect_to @user
  #    else
  #      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
  #      render :new
  #    end
  #  end

  def show
    @choices = @user.choices.page(params[:page]).per(10).order(created_at: :desc)
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:success] = t 'users.flash.success'
    else
      flash[:danger] = t 'users.flash.danger'
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
    flash[:success] = t 'users.flash.destroy'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def current_user?
    @user = User.find(params[:id])
    return if @user.id == current_user.id

    redirect_to root_path
    flash[:danger] = t 'users.flash.not authorized'
  end
end
