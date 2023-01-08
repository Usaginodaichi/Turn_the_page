class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @todoposts = @user.to_do_posts.page(params[:page]).reverse_order
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "会員情報の編集が完了しました"
      redirect_to public_user_path(@user)
    else
      render :edit
    end
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:to_do_post_id)
    @favorite_posts = ToDoPost.find(favorites)
  end

  private
  def user_params
    params.require(:user).permit(:profile_image, :last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :introduction, :purpose, :email, :is_deleted)
  end
end
