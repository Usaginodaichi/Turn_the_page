class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    to_do_post = ToDoPost.find(params[:to_do_post_id])
    PostComment.find_by(id: params[:id],to_do_post_id: params[:to_do_post_id]).destroy
    redirect_to admin_to_do_post_path(to_do_post)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:user_id, :to_do_post_id, :comment)
  end

end
