class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    to_do_post = ToDoPost.find(params[:to_do_post_id])
    post_comment = PostComment.new(post_comment_params)
    post_comment.user_id = current_user.id
    post_comment.to_do_post_id = to_do_post.id
    if post_comment.save
      flash[:notice] = "コメントしました"
      redirect_to public_to_do_post_path(to_do_post)
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:user_id, :to_do_post_id, :comment)
  end


end
