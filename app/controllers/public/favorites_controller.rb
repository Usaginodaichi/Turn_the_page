class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  def create
    to_do_post = ToDoPost.find(params[:to_do_post_id])
    favorite = current_user.favorites.new(to_do_post_id:to_do_post.id)
    favorite.save
    redirect_to public_to_do_post_path(to_do_post)
  end

  def destroy
    to_do_post = ToDoPost.find(params[:to_do_post_id])
    favorite = current_user.favorites.find_by(to_do_post_id:to_do_post.id)
    favorite.destroy
    redirect_to public_to_do_post_path(to_do_post)
  end
end
