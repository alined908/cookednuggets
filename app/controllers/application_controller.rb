class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_sidebars

  def index
    @events = Event.where('start_date <= ? AND end_date >= ?', Date.today, Date.today)
    @completed = Official.limit(12).where("start <= ?", DateTime.now).order(start: :desc).includes(:team1, :team2)
    @upcoming = Official.limit(12).where("end >= ?", DateTime.now).includes(:team1, :team2)
    @news = New.order(created_at: :desc).limit(15)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :firstname, :lastname])
  end

  def get_sidebars
    @discs = (ForumThread.order(updated_at: :desc).limit(10) + Official.order(updated_at: :desc).limit(10) + New.order(updated_at: :desc).limit(10)).sort_by(&:updated_at).reverse[0..15]
  end
end
