class Officials::MapsController < ApplicationController
  before_action :set_map, except: [:create]

  def create
    @map = Map.new(map_params)
    (params[:score].nil? ? (@map.score = [0,0]) : (@map.score = params[:score].map{|num| num.to_i}))
    authorize @map
    if @map.save
      flash[:success] = "Successfully created a map"
    else
      flash[:danger] = @map.errors.full_messages
    end
    redirect_to match_path(@map.official)
  end

  def update
    authorize @map
    (params[:score].nil? ? (@map.score = [0,0]) : (@map.score = params[:score].map{|num| num.to_i}))
    @map.def_players(params[:players])
    if @map.update_attributes(map_params)
      flash[:success] = "Successfully updated map"
    else
      flash[:danger] = "Unable to update map, a field was input incorrectly"
    end
    redirect_to match_path(@map.official_id)
  end

  def destroy
    authorize @map
    match = @map.official
    flash[:success] = "Successfully deleted map"
    @map.destroy
    redirect_to match_path(match)
  end

  private
  def set_map
    @map = Map.find(params[:id])
  end

  def map_params
    params.require(:map).permit(:official_id, :winner_id, :score, :name, :state, :performances)
  end
end
