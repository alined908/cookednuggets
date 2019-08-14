class Forums::ForumPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable
  #before_action :require_permission, only: [:update]

  def create
    @post = @commentable.forum_posts.new(forum_post_params)
    @post.user = current_user
    @post.thread_id = @parent_id
    if @post.save
      flash[:success] = "Post successfully created."
    else
      flash[:danger] = @post.errors.full_messages
    end
    redirect_to request.referrer
  end

  def update
    puts "hello"
    @post = ForumPost.find(params[:id])
    @post.body = forum_post_params[:body]
    if @post.save
      flash[:success] = "Post successfully edited."
    else
      flash[:danger] = @post.errors.full_messages
    end
    redirect_to request.referrer
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
        @parent_id = @commentable.thread_id
      elsif params[:thread_id]
        @commentable = ForumThread.find(params[:thread_id])
        @parent_id = params[:thread_id]
      elsif params[:match_id]
        @commentable = Official.find(params[:match_id])
        @parent_id = params[:match_id]
      elsif params[:news_id]
        @commentable = New.find(params[:news_id])
        @parent_id = params[:news_id]
      else
        @forumpost = ForumPost.find(params[:id])
      end
    end

    def forum_post_params
      params.require(:forum_post).permit(:body)
    end

end
