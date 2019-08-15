class Officials::SectionsController < ApplicationController
  before_action :set_section, only: [:show, :destroy, :update]
  before_action :set_event

  def show
    @sections = @event.sections
    @officials = @section.officials.includes(:team1, :team2)
    @regulars = @officials.where("match_type = ?", 'regular').includes(:winner, maps: :winner)
    @teams, @standings = Section.standings(@event.teams, @regulars)
  end

  def create
    @section = Section.new(section_params)
    @section.event = @event
    if @section.save
      flash[:success] = "Section successfully created."
      redirect_to event_section_path(@event, @section)
    else
      flash[:danger] = @section.errors.full_messages
      redirect_to event_path(@event)
    end
  end

  def update

  end

  def destroy
    
  end

  private
    def set_section
      @section = Section.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    def section_params
      params.require(:section).permit(:name, :start, :end)
    end
end
