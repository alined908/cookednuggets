class Officials::RankingsController < ApplicationController

  def index
    @events = Event.where(display_ranking: true)
    @primary = @events.where(primary_ranking: true).first.teams.order(rating: :desc)
  end


end
