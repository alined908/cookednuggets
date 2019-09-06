class Users::UsersController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    authorize User
    @users = User.all.order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.forum_posts.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
    @user.destroy
    flash[:success] = "User successfully deleted"
    redirect_to users_path
  end

  private

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "username"
  end

  def sort_direction
    %w[asc desc].include?(params[:d]) ? params[:d] : "asc"
  end
end
