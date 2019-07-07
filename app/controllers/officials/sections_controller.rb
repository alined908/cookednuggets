class Officials::SectionsController < ApplicationController
  before_action :set_section

  def show
    @event = Event.find(params[:event_id])
    @sections = @event.sections
    @officials = @section.officials.includes(:team1, :team2)
    @regulars = @officials.where("match_type = ?", 'regular').includes(:winner, maps: :winner)
    @teams, @standings = Section.standings(@event.teams, @regulars)
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
    def set_section
      @section = Section.find(params[:id])
    end

    def section_params

    end
end
