class Admin::ToDoPostsController < ApplicationController
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @todoposts = @user.to_do_posts.all
    end
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

  private

  def to_do_post_params
    params.require(:to_do_post).permit(:image, :user_id, :title, :description, :status, :start_date, :end_date)
  end

end
