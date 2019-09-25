class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.friendly.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
  end
end