class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
    @events = Event.where('start_date <= ? AND end_date >= ?', Date.today, Date.today)
    @completed = Official.limit(15).where("start <= ?", DateTime.now).order(start: :desc).includes(:team1, :team2)
    @upcoming = Official.limit(15).where("end >= ?", DateTime.now).includes(:team1, :team2)
    @threads = ForumThread.limit(10)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :firstname, :lastname])
  end
end
