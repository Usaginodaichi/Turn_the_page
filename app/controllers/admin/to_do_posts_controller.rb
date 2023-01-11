class Admin::ToDoPostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @todoposts = @user.to_do_posts.all
    end
  end

  def show
    @todopost = ToDoPost.find(params[:id])
    @user = @todopost.user
  end

  def edit
    @todopost = ToDoPost.find(params[:id])
  end

  def update
    @todopost = ToDoPost.find(params[:id])
    if @todopost.update(to_do_post_params)
      flash[:notice] = "編集が完了しました"
      redirect_to
    else
      render :edit
    end
  end

  def destroy
    @todopost = ToDoPost.find(params[:id])
    @user = @todopost.user
    @todoposts = @user.to_do_posts.all
    @todopost.destroy
    flash[:notice] = "投稿を削除しました。ユーザー一覧画面へ戻ります"
    @users = User.all
    render template: "admin/homes/top"
  end

  private

  def to_do_post_params
    params.require(:to_do_post).permit(:image, :user_id, :title, :description, :status, :start_date, :end_date)
  end

end
