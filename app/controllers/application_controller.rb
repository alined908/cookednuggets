class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_discs
  before_action :get_matches

  def index
    @events = Event.where('start_date <= ? AND end_date >= ?', Date.today, Date.today)
    @completed = Official.limit(12).where("start <= ?", DateTime.now).order(start: :desc).includes(:team1, :team2, :event, :section)
    @upcoming = Official.limit(12).where("end >= ?", DateTime.now).includes(:team1, :team2, :event, :section)
    @news = New.order(created_at: :desc).limit(15)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :firstname, :lastname, :avatar, :country])
  end

  def get_discs
    @disable_1 = false
    @threads_sb = ForumThread.order(updated_at: :desc).limit(10)
    @matches_sb = Official.order(updated_at: :desc).limit(10)
    @news_sb = New.order(updated_at: :desc).limit(10)
    @discs = (@threads_sb + @matches_sb + @news_sb).sort_by(&:updated_at).reverse[0..15]
  end

  def get_matches
    @completed = Official.limit(7).where("start < ?", DateTime.now).order(start: :desc).includes(:team1, :team2, :event, :section)
    @upcoming = Official.limit(7).where("end >= ?", DateTime.now).includes(:team1, :team2, :event, :section)
  end
end
