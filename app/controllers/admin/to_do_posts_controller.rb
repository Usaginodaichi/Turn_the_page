class Admin::ToDoPostsController < ApplicationController
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @todoposts = @user.to_do_posts.all
    end
  end

  def edit
  end
end
