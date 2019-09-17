class Officials::SectionsController < ApplicationController
  before_action :set_section, only: [:show, :destroy, :update]
  before_action :set_event

  def show
    @match = Official.new
    @sections = @event.sections
    @officials = @section.officials.includes(:team1, :team2)
    @regulars = @officials.where("match_type = ?", "regular").includes(:winner, maps: :winner)
    @teams, @standings = Section.standings(@event.teams, @regulars)
  end

  def create
    @section = Section.new(section_params)
    @section.event = @event
    authorize @section
    if @section.save
      flash[:success] = "Section successfully created."
      redirect_to event_section_path(@event, @section)
    else
      flash[:danger] = @section.errors.full_messages
      redirect_to event_path(@event)
    end
  end

  def update
    authorize @section
    if @section.update_attributes(section_params)
      flash[:success] = "Successfully updated section"
    else
      flash[:danger] = "Unable to update section."
    end
    redirect_to event_section_path(@event, @section)
  end

  def destroy
    authorize @section
    flash[:success] = "Successfully destroyed section"
    @section.destroy
    redirect_to event_path(@event)
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
