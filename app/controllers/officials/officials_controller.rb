class Officials::OfficialsController < ApplicationController
  before_action :set_match, only: [:show, :new, :destroy, :edit]

  def index
    if params[:f] == "results"
      @officials = Official.limit(40).where("start <= ?", DateTime.now).order(start: :desc).includes(:team1, :team2, section: :event)
    else
      @officials = Official.limit(40).where("end >= ?", DateTime.now).includes(:team1, :team2, section: :event)
    end
  end

  def show
    @section, @teams = Section.find(@match.section_id), Team.find(@match.team1_id, @match.team2_id)
    @event, @maps = Event.find(@section.event_id), @match.maps
    @h2hs, @recents = Official.h2hs(@teams, @match.id), Official.recents(@teams, @match.id)
    @maps_json = Map.get_perfs(@maps, @teams)

    @forum_post = ForumPost.new
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
