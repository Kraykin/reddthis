class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user, only: [:show, :upvote, :downvote]
  load_and_authorize_resource

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
  end

  def upvote
    @user.upvote_by current_user
    redirect_back(fallback_location: root_path)
  end

  def downvote
    @user.downvote_from current_user
    redirect_back(fallback_location: root_path)
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end
end
