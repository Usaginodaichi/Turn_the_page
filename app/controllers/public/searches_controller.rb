class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
      render :index
    else
      @todoposts = ToDoPost.looks(params[:search], params[:word])
      render :index
    end
  end


end
