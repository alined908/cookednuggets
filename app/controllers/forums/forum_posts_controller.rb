class Forums::ForumPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable

  def create
    @forum_post = @commentable.forum_posts.new(forum_post_params)
    @forum_post.user = current_user

    if @forum_post.save
      flash[:success] = "Post successfully created"
    else
      flash[:danger] = @forum_post.errors.full_messages
    end

    redirect_to request.referrer
  end

  private
    def find_commentable
      @commentable = ForumPost.find(params[:forum_post_id]) if params[:forum_post_id]
      @commentable = ForumThread.find(params[:forum_thread_id]) if params[:forum_thread_id]
    end

    def forum_post_params
      params.require(:forum_post).permit(:body)
    end

end
