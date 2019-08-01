class Officials::OfficialsController < ApplicationController
  before_action :set_match, only: [:show, :new, :destroy, :edit]

  def index
    if params[:f] == "comp"
      @officials = Official.where("start <= ?", DateTime.now).paginate(:page => params[:page]).order(start: :desc).includes(:team1, :team2, :event, :section)
    else
      @officials = Official.where("end >= ?", DateTime.now).paginate(:page => params[:page]).includes(:team1, :team2, :event, :section)
    end
  end

  def show
    @section, @teams = Section.find(@match.section_id), Team.find(@match.team1_id, @match.team2_id)
    @event, @maps = Event.find(@section.event_id), @match.maps
    @h2hs, @recents = Official.h2hs(@teams, @match.id), Official.recents(@teams, @match.id)
    @maps_json = Map.get_perfs(@maps, @teams)
    @forum_post = ForumPost.new
    @completed = Official.where(event_id: @event.id).where("start <= ?", DateTime.now).order(start: :desc).limit(5).includes(:team1, :team2)
    @upcoming = Official.where(event_id: @event.id).where("end >= ?", DateTime.now).limit(5).includes(:team1, :team2)
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
