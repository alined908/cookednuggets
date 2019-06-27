class Officials::TeamsController < ApplicationController
  before_action :set_team, only: [:show, :new, :destroy, :edit]
  
  def index
    @teams = Team.all
    @team = Team.new
  end

  def show
    @players = @team.players
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      flash[:success] = "Successfully created team."
      redirect_to teams_path
    else
      flash[:danger] = @team.errors.full_messages
      render 'index'
    end

  end

  def update

  end

  def destroy

  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name, :shortname, :website, :logo, :country)
    end
end