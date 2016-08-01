class CommentsController < ApplicationController
  layout nil

  before_action :set_post, only: [:create]
  before_action -> { authorize(Comment.new) }, only: [:create]

  def create
    @comment = @post.comments.create!(comment_params) do |comment|
      comment.user = current_user
    end
    respond_to do |format|
      format.js
      format.json { render :comment, status: :created, location: @comment }
    end
  end

  private

    def set_post
      @blog = Blog.friendly.find(params[:blog_id])
      @post = Post.friendly.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:comment)
    end
end
