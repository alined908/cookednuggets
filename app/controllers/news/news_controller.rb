class News::NewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_new, only: [:show]
  before_action :news_params, except: [:show, :destroy]

  def show

  end

  def create
    @article = New.new(news_params)
    @article.user = current_user

    if @article.save
      flash[:success] = "Thread successfully created"
      redirect_to @article
    else
      flash[:danger] = @article.errors.full_messages
      redirect_to threads_path(:f => "news")
    end
  end

  def update

  end

  def destroy

  end

  private
    def set_new
      @news = New.find(params[:id])
    end

    def news_params
      params.require(:new).permit(:subject, :article)
    end

end
