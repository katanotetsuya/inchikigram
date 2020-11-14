class UsersController < ApplicationController

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
  	@user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
      if @user.update(user_params)
         #パスワード変更を行った場合はログアウトするためサインインを実行してから実行する
         bypass_sign_in(@user)
         redirect_to user_path(@user), notice: "You have updated user successfully."
      else
        render "show"
      end
  end

  def following
    #@userがフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.following
    render 'index_follow'
  end

  def followers
    #@userをフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'index_follower'
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :profile_image, :email)
  end

end
