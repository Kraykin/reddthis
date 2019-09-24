class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.friendly.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end
end
