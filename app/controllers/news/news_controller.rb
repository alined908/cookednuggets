class News::NewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_new, only: [:show, :update, :destroy]
  before_action :news_params, except: [:show, :destroy]

  def show
    @post = ForumPost.new
  end

  def create
    @article = New.new(news_params)
    @article.user = current_user

    if @article.save
      flash[:success] = "Article successfully created"
      redirect_to @article
    else
      flash[:danger] = @article.errors.full_messages
      redirect_to threads_path(:f => "news")
    end
  end

  def update
    authorize @news
    if @news.update_attributes(news_params)
      flash[:success] = "Successfully updated news article"
    else
      flash[:danger] = "Unable to update news article"
    end
    redirect_to news_path(@news)
  end

  def destroy
    authorize @news
    flash[:success] = "Article titled: '" + @news.subject + "'   successfully destroyed"
    @news.destroy
    redirect_to threads_path(:f => "news")
  end

  private
    def set_new
      @news = New.find(params[:id])
    end

    def news_params
      params.require(:new).permit(:subject, :article, :pictures)
    end

end
