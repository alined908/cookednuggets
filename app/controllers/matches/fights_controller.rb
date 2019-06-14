class Matches::FightsController < ApplicationController
  before_action :authenticate_user!

  def create
    @match = Match.find(params[:match_id])
    Fight.import(csv_params[:fight_csv], @match)
    flash[:success] = "Successfully imported fight statistics"
    redirect_to user_match_path(current_user, @match)
  end

  private
  def csv_params
    params.require(:fight).permit(:fight_csv)
  end
end
