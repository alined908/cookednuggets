class Forums::ForumPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_forum_thread

  def create
    @forum_post = ForumPost.new(forum_post_params)
    @forum_post.user = current_user
    @forum_post.forum_thread = @forum_thread

    if @forum_post.save
      flash[:success] = "Post successfully created"
    else
      flash[:danger] = @forum_post.errors.full_messages
    end
    redirect_to forum_thread_path(@forum_thread)
  end

  private
    def set_forum_thread
      @forum_thread = ForumThread.find(params[:forum_thread_id])
    end

    def forum_post_params
      params.require(:forum_post).permit(:body)
    end

end
