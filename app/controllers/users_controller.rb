class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.friendly.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
  end
end
