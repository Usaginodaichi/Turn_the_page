class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    to_do_post = ToDoPost.find(params[:to_do_post_id])
    post_comment = PostComment.new(post_comment_params)
    post_comment.user_id = current_user.id
    post_comment.to_do_post_id = to_do_post.id
    if post_comment.save
      flash[:notice] = "コメントしました"
      redirect_to to_do_post_path(to_do_post)
    else
      flash[:notice] = 'コメントに失敗しました'
      @todopost = ToDoPost.find(params[:to_do_post_id])
      @user = current_user
      @post_comment = PostComment.new
      render template: "public/to_do_posts/show"
    end
  end

  def destroy
    to_do_post = ToDoPost.find(params[:to_do_post_id])
    PostComment.find_by(id: params[:id],to_do_post_id: params[:to_do_post_id]).destroy
    redirect_to to_do_post_path(to_do_post)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:user_id, :to_do_post_id, :comment)
  end


end
