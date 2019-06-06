class GeneralsController < ApplicationController
  before_action :authenticate_user!

  def create
    @match = Match.find(params[:match_id])
    General.import(csv_params[:general_csv], @match)
    flash[:success] = "Successfully imported general statistics"
    redirect_to user_match_path(current_user, @match)
  end

  private
  def csv_params
    params.require(:general).permit(:general_csv)
  end
end
