class Officials::SectionsController < ApplicationController
  before_action :set_section, only: [:edit, :destroy]

  def show
    @event = Event.find(params[:event_id])
    @teams = @event.teams
    @sections = @event.sections
    @officials = @sections.find(params[:id]).officials.includes(:team1, :team2)
    @regulars = @officials.where("match_type = ?", 'regular').includes(:winner, maps: :winner)
    @standings = Section.standings(@teams, @regulars)
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
