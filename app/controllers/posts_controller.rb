class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource

  def index
    @posts = Post.includes(:user).paginate(page: params[:page], per_page: 10)
  end

  def show
    @comments = @post.comments.includes(:user).paginate(page: params[:page])
  end

  def new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  def upvote
    @post.upvote_by current_user
    redirect_back(fallback_location: root_path)
  end

  def downvote
    @post.downvote_from current_user
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id, :image)
  end
end
