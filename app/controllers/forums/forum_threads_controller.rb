class Forums::ForumThreadsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_forum_thread, except: [:index, :new, :create]

  def index
    @forum_thread = ForumThread.new
    @forum_threads = ForumThread.all.includes(:user)
    @thread_info = ForumThread.info(@forum_threads, true)
  end

  def show
    @thread_info = ForumThread.info([@forum_thread], false)
  end

  def create
    @forum_thread = ForumThread.new(forum_thread_params)
    @forum_thread.user = current_user

    if @forum_thread.save
      flash[:success] = "Thread successfully created"
      redirect_to thread_path(@forum_thread)
    else
      flash[:danger] = @forum_thread.errors.full_messages
      redirect_to threads_path
    end
  end

  def destroy

  end

  private
    def set_forum_thread
      @forum_thread = ForumThread.find(params[:id])
    end

    def forum_thread_params
      params.require(:forum_thread).permit(:subject, :description)
    end
end
