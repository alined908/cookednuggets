class Matches::CompositionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @match = Match.find(params[:match_id])
    Composition.import(csv_params[:composition_csv], @match)
    flash[:success] = "Successfully imported compositions"
    redirect_to user_match_path(current_user, @match)
  end

  private
  def csv_params
    params.require(:composition).permit(:composition_csv)
  end
end
