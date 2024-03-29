class Public::ToDoPostsController < ApplicationController
  before_action :authenticate_user!
  def new
    @todopost = current_user.to_do_posts.new
  end

  def create
    @todopost = current_user.to_do_posts.new(to_do_post_params)
    if @todopost.save
      flash[:notice] = "新規投稿が完了しました"
      redirect_to to_do_posts_path(@todopost)
    else
      render :new
    end
  end

  def index
    # 新規投稿順に表示する
    @todoposts = ToDoPost.order(id: :DESC).page(params[:page])
    @user = current_user
  end

  def show
    @todopost = ToDoPost.find(params[:id])
    @user = current_user
    @post_comment = PostComment.new
  end

  def edit
    @todopost = current_user.to_do_posts.find(params[:id])
  end

  def update
    @todopost = current_user.to_do_posts.find(params[:id])
    if @todopost.update(to_do_post_params)
      flash[:notice] = "編集が完了しました"
      redirect_to to_do_posts_path
    else
      render :edit
    end
  end

  def destroy
    @todopost = current_user.to_do_posts.find(params[:id])
    @todopost.destroy
    redirect_to to_do_posts_path
  end




  private

  def to_do_post_params
    params.require(:to_do_post).permit(:image, :user_id, :title, :description, :status, :start_date, :end_date)
  end
end
