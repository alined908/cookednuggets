class Forums::ForumPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable, except: [:update, :destroy]
  before_action :set_post, only: [:update, :destroy]

  def create
    @post = @commentable.forum_posts.new(forum_post_params)
    authorize @post
    @post.user = current_user
    if @post.save
      flash[:success] = "Post successfully created."
    else
      flash[:danger] = @post.errors.full_messages
    end
    redirect_to find_parent_route?(@post)
  end

  def update
    authorize @post
    @post.body = forum_post_params[:body]
    if @post.save
      flash[:success] = "Post successfully edited."
    else
      flash[:danger] = @post.errors.full_messages
    end
    redirect_to find_parent_route?(@post)
  end

  def destroy
    authorize @post
    route = find_parent_route?(@post)
    @post.destroy
    flash[:success] = "Post successfully deleted."
    redirect_to route
  end

  def vote
    @prev_vote = @forumpost.votes.where(user_id: current_user.id)
    if @prev_vote.any?
      @prev_vote.destroy_all
    end

    @vote = @forumpost.votes.new(direction: params[:direction])
    @vote.user = current_user
    @vote.save

    respond_to do |format|
      format.js
    end
  end

  private
    def find_commentable
      if params[:post_id]
        @commentable = ForumPost.find(params[:post_id])
      elsif params[:thread_id]
        @commentable = ForumThread.find(params[:thread_id])
      elsif params[:match_id]
        @commentable = Official.find(params[:match_id])
      elsif params[:news_id]
        @commentable = New.find(params[:news_id])
      else
        @forumpost = ForumPost.find(params[:id])
      end
    end

    def find_parent_route?(child)
      parent = ForumPost.find_parent(child)
      type = parent.class

      if type == ForumThread
        return thread_path(parent)
      elsif type == Official
        return match_path(parent)
      elsif type == New
        return news_path(parent)
      end
    end

    def forum_post_params
      params.require(:forum_post).permit(:body)
    end

    def set_post
      @post = ForumPost.find(params[:id])
    end
end
