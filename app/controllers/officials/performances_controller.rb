class Officials::PerformancesController < ApplicationController
  def update
    @perf = Performance.find(params[:id])

    if @perf.update_attributes(perf_params)
      flash[:success] = "Successfully updated starting player"
    else
      flash[:danger] = "Unable to update starting player"
    end
    redirect_to match_path(@perf.map.official)
  end

  private
  def perf_params
    params.require(:performance).permit(:player_id, :map_id, :team_id)
  end
end
