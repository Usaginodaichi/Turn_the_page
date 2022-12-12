class Public::ToDoPostsController < ApplicationController
  before_action :authenticate_user!
  def new
    @todopost = current_user.to_do_posts.new
  end

  def create
    @todopost = current_user.to_do_posts.new(to_do_post_params)
    if @todopost.save
      flash[:notice] = "新規投稿が完了しました"
      redirect_to public_to_do_posts_path(@todopost)
    elserail
      render :new
    end
  end

  def index
    @todoposts = current_user.to_do_posts.all
  end

  def edit
  end

  def show
  end

  private

  def to_do_post_params
    params.require(:to_do_post).permit(:user_id, :title, :description, :status, :start_date, :end_date)
  end
end
