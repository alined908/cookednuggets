class Forums::ForumPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable
  #before_action :require_permission, only: [:update]

  def create
    @forum_post = @commentable.forum_posts.new(forum_post_params)
    @forum_post.user = current_user
    @forum_post.thread_id = @parent_id
    if @forum_post.save
      flash[:success] = "Post successfully created."
    else
      flash[:danger] = @forum_post.errors.full_messages
    end
    redirect_to forum_thread_path(@parent_id)
  end

  def update
    @forum_post = ForumPost.find(params[:id])
    @forum_post.body = forum_post_params[:body]
    if @forum_post.save
      flash[:success] = "Post successfully updated."
    else
      flash[:danger] = @forum_post.errors.full_messages
    end
    redirect_to forum_thread_path(@parent_id)
  end

  private
    def find_commentable
      if params[:forum_post_id]
        @commentable = ForumPost.find(params[:forum_post_id])
        @parent_id = @commentable.thread_id
      end
      if params[:forum_thread_id]
        @commentable = ForumThread.find(params[:forum_thread_id])
        @parent_id = params[:forum_thread_id]
      end
    end

    def forum_post_params
      params.require(:forum_post).permit(:body)
    end

end
