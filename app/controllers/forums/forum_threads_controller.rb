require 'will_paginate/array'

class Forums::ForumThreadsController < ApplicationController
  skip_before_action :get_discs, except: [:show]
  before_action :disable_discs, except: [:show]
  before_action :authenticate_user!, only: [:create]
  before_action :set_forum_thread, except: [:index, :new, :create]

  def index
    @forum_thread = ForumThread.new

    if params[:f] == "threads"
      @discs = ForumThread.order(updated_at: :desc).includes(:user).paginate(:page => params[:page], :per_page => 20)
    elsif params[:f] == "news"
      @discs = New.order(updated_at: :desc).includes(:user).paginate(:page => params[:page], :per_page => 20)
      @new = New.new
    elsif params[:f] == "matches"
      @discs = Official.order(updated_at: :desc).paginate(:page => params[:page], :per_page => 20)
    else
      @threads_sb = ForumThread.order(updated_at: :desc).includes(:user)
      @matches_sb = Official.order(updated_at: :desc)
      @news_sb = New.order(updated_at: :desc).includes(:user)
      @discs = (@threads_sb + @matches_sb + @news_sb).sort_by(&:updated_at).reverse.paginate(:page => params[:page], :per_page => 20)
    end

  end

  def show

  end

  def create
    @forum_thread = ForumThread.new(forum_thread_params)
    authorize @forum_thread
    @forum_thread.user = current_user

    if @forum_thread.save
      flash[:success] = "Thread successfully created"
      redirect_to thread_path(@forum_thread)
    else
      flash[:danger] = @forum_thread.errors.full_messages
      redirect_to threads_path
    end
  end

  def update
    authorize @forum_thread
    @forum_thread.update_attributes(forum_thread_params)
    redirect_to thread_path(@forum_thread)
  end

  def destroy
    authorize @forum_thread
    @forum_thread.destroy
    flash[:success] = "Thread successfully deleted."
    redirect_to threads_path
  end

  private
    def disable_discs
      @disable_1 = true
    end

    def set_forum_thread
      @forum_thread = ForumThread.find(params[:id])
    end

    def forum_thread_params
      params.require(:forum_thread).permit(:subject, :description)
    end
end
