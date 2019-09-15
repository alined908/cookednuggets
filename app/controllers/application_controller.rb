class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_discs
  before_action :get_matches

  def index
    @events = Event.where("start_date <= ? AND end_date >= ?", Date.today, Date.today)
    @completed = Official.limit(12).where("start < ?", DateTime.now - 3.hours).order(start: :desc).includes(:team1, :team2, :event, :section)
    puts "DWdadawdaw"
    @upcoming = Official.limit(12).where("end >= ?", DateTime.now).includes(:team1, :team2, :event, :section)
    @featured = New.where(featured: true).order(created_at: :desc)[0]
    if @featured.nil?
      @all_news = New.order(created_at: :desc).limit(20)
    else
      @all_news = New.where.not(id: @featured.id).order(created_at: :desc).limit(20)
    end
    @news_today, @news_tw, @news_pm = @all_news.where(:created_at => Date.current - 1..Date.current), @all_news.where(:created_at => Date.current - 7..Date.current - 1), @all_news.where(:created_at => Date.current - 30..Date.current - 7)
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
    @completed = Official.limit(7).where("start < ?", DateTime.now - 3.hours).order(start: :desc).includes(:team1, :team2, :event, :section)
    @upcoming = Official.limit(7).where("end >= ?", DateTime.now).includes(:team1, :team2, :event, :section)
  end
end
