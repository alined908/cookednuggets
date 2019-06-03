class UsersController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "Welcome to Cooked Nuggets!"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = @user.errors.full_messages
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:firstname, :lastname, :username, :email, :password, :password_confirmation)
    end
end
