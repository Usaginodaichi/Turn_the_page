class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @Todoposts = ToDoPost.looks(params[:search], params[:word])
    end
  end


end
