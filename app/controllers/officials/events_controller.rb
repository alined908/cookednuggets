class Officials::EventsController < ApplicationController
  before_action :set_event, only: [:show, :destroy, :update]
  before_action :get_event_matches, except: [:index, :create, :update]

  def index
    @teams = Team.all
    @event = Event.new
    if params[:s] == 'completed'
      @events = Event.where("? > end_date", Date.current)
    else
      @events = Event.where("start_date <= ? AND end_date >= ?", Date.current, Date.current)
    end
  end

  def show
    @section = Section.new
    @regulars = []
    @event.sections.each {|stage|
       @regulars += stage.officials.where("match_type = ?", "regular").includes(:winner, :team1, :team2, maps: :winner)}
    @teams, @standings = Section.standings(@event.teams, @regulars)
  end

  def create
    @event = Event.new(event_params)
    authorize(@event)
    @event.check_teams(params[:teams])

    if @event.save
      flash[:success] = "Event successfully created."
      redirect_to event_path(@event)
    else
      flash[:danger] = @event.errors.full_messages
      redirect_to events_path
    end
  end

  def update
    authorize @event
    if @event.update_attributes(event_params.except(:teams))
      @event.check_teams(params[:teams])
      flash[:success] = "Event successfully updated."
    else
      flash[:danger] = "Event field caused an error."
    end
    redirect_to @event
  end

  def destroy
    authorize @event
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
      params.require(:event).permit(:name, :location, :country, :prize, :start_date, :end_date, :desc, :teams, :logo)
    end

    def get_event_matches
      @completed = Official.where(event_id: @event.id).where(start: (DateTime.now - 3.months)..(DateTime.now - 3.hours)).order(start: :desc).limit(5).includes(:team1, :team2, :event, :section)
      @upcoming = Official.where(event_id: @event.id).where(end: DateTime.now..(DateTime.now + 3.months)).limit(5).includes(:team1, :team2, :event, :section)
    end
end
