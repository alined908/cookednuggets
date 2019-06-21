class Matches::MatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match, only: [:show, :edit, :update, :destroy]

  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
    @compositions = Composition.where(match_id: @match).order(roundtype: :desc)
    @generals = General.where(match_id: @match).order(player: :asc)
    @fights = Fight.where(match_id: @match)
  end

  # GET /matches/new
  def new
    @match = Match.new
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches
  def create
    @match = Match.new(match_params)
    @match.user = current_user

    if @match.save
      flash[:success] = "Match successfully created! Upload compositions, fights, and general statistics!"
      redirect_to user_match_path(current_user, @match)
    else
      flash.now[:danger] = @match.errors.full_messages
      render 'new'
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    if @match.update(match_params)
      flash[:success] = "Match was successfully updated."
      redirect_to user_match_path(current_user, @match)
    else
      flash[:danger] = @match.errors.full_messages
      render 'edit'
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy
    flash[:success] = "Match successfully destroyed."
    redirect_to user_matches_path(current_user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:date, :left_team, :map, :right_team)
    end
end
