class Officials::RankingsController < ApplicationController
  helper_method :sort_column, :sort_direction, :selected_event

  def index
    @events = Event.where(display_ranking: true)
    @primaries = selected_event.teams
    @default = @primaries.order(rating: :desc)
    @custom = @primaries.order(sort_column + " " + sort_direction)
  end

  private

  def sort_column
    Team.column_names.include?(params[:sort]) ? params[:sort] : "rating"
  end

  def sort_direction
    %w[asc desc].include?(params[:d]) ? params[:d] : "desc"
  end

  def selected_event
    queried_event = Event.find_by(shortname: params[:e])
    queried_event.nil? ? Event.find_by(primary_ranking: true) : queried_event
  end
end
