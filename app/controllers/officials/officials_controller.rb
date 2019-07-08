class Officials::OfficialsController < ApplicationController
  before_action :set_match, only: [:show, :new, :destroy, :edit]

  def index

  end

  def show
    @section = Section.find(@match.section_id)
    @event = Event.find(@section.event_id)
    @teams = Team.find(@match.team1_id, @match.team2_id)
    @maps = @match.maps
    @h2hs, @recents = Official.h2hs(@teams, @match.id), Official.recents(@teams, @match.id)
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
    def set_match
      @match = Official.find(params[:id])
    end

    def match_params
      params.require(:match).permit()
    end
end
