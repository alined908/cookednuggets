class Officials::OfficialsController < ApplicationController
  before_action :set_match, except: [:create, :index]

  def index
    if params[:f] == "comp"
      @officials = Official.where("start < ?", DateTime.now).paginate(:page => params[:page]).order(start: :desc).includes(:team1, :team2, :event, :section)
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
    @completed = Official.where(event_id: @event.id).where("start <= ?", DateTime.now).order(start: :desc).limit(5).includes(:team1, :team2, :event, :section)
    @upcoming = Official.where(event_id: @event.id).where("end >= ?", DateTime.now).limit(5).includes(:team1, :team2, :event, :section)
  end

  def create
    @match = Official.new(match_params)
    (params[:score].nil? ? (@match.score = [0,0]) : (@match.score = params[:score].map{|num| num.to_i}))
    authorize @match
    if @match.save
      flash[:success] = "Match successfully created."
      redirect_to match_path(@match)
    else
      flash[:danger] = @match.errors.full_messages
      redirect_to event_section_path(params[:official][:event_id], params[:official][:section_id])
    end
  end

  def update
    authorize @match
    (params[:score].nil? ? (@match.score = [0,0]) : (@match.score = params[:score].map{|num| num.to_i}))
    if @match.update_attributes(match_params)
      flash[:success] = "Match successfully updated."
    else
      flash[:danger] = "Unable to edit match. Field incorrectly inputted."
    end
    redirect_to match_path(@match)
  end

  def destroy
    authorize @match
    @event, @section = @match.event, @match.section
    flash[:success] = "Successfully destroyed match"
    @match.destroy
    redirect_to event_section_path(@event, @section)
  end

  private
    def set_match
      @match = Official.find(params[:id])
    end

    def match_params
      params.require(:official).permit(:team1_id, :team2_id, :winner_id, :identifier, :label, :score, :match_type, :map_count, :start, :end, :section_id, :event_id, :subject)
    end
end
