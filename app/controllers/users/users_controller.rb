class Users::UsersController < ApplicationController

  def index
    @authorize
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.forum_posts.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end
end
