class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  def create
    @todopost = ToDoPost.find(params[:to_do_post_id])
    favorite = current_user.favorites.new(to_do_post_id: params[:to_do_post_id])
    favorite.save
  end

  def destroy
    @todopost = ToDoPost.find(params[:to_do_post_id])
    favorite = current_user.favorites.find_by(to_do_post_id: params[:to_do_post_id])
    favorite.destroy
  end
end
