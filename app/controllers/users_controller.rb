class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  load_and_authorize_resource

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
  end
end
