class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment[:user_id] = current_user.id

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was successfully created.'
    else
      redirect_to post_path(@post), notice: "Comment can't be blank"
    end
  end

  def update
  end

  def destroy
  end

  def upvote
    @comment.upvote_by current_user
    redirect_back(fallback_location: root_path)
  end

  def downvote
    @comment.downvote_from current_user
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
