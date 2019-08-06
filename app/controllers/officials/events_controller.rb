class Officials::EventsController < ApplicationController
  before_action :set_event, only: [:show, :destroy, :edit]
  before_action :get_event_matches, except: [:index]

  def index
    if params[:s] == 'completed'
      @events = Event.where('? > end_date', Date.today)
    else
      @events = Event.where('start_date <= ? AND end_date >= ?', Date.today, Date.today)
    end
    @length = @events.length
  end

  def show
    @regulars = []
    @event.sections.each {|stage|
       @regulars += stage.officials.where("match_type = ?", 'regular').includes(:winner, :team1, :team2, maps: :winner)}
    @teams, @standings = Section.standings(@event.teams, @regulars)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "Event successfully created."
      redirect_to events_path
    else
      flash.now[:danger] = "Event information wrong."
      render :new
    end
  end

  def edit

  end

  def update
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "Event successfully edited."
      redirect_to events_path
    else
      flash.now[:danger] = "Event information wrong."
      render :edit
    end
  end

  def destroy
    name = @event.name
    @event.destroy
    flash[:success] = "Event '#{name}' successfully deleted."
    redirect_to events_path
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :location, :country, :prize, :start_date, :end_date, :desc)
    end

    def get_event_matches
      @completed = Official.where(event_id: @event.id).where("start <= ?", DateTime.now).order(start: :desc).limit(5).includes(:team1, :team2)
      @upcoming = Official.where(event_id: @event.id).where("end >= ?", DateTime.now).limit(5).includes(:team1, :team2)
    end
end
