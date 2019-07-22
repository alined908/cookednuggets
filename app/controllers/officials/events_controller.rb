class Officials::EventsController < ApplicationController
  before_action :set_event, only: [:show, :destroy, :edit]

  def index
    @events = Event.all
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
end
