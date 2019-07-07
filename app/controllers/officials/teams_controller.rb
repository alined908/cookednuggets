class Officials::TeamsController < ApplicationController
  before_action :set_team, only: [:show, :new, :destroy, :edit]

  def index
    @teams = Official::Team.all
    @team = Official::Team.new
  end

  def show
    @players = @team.players
    @officials = Official.includes(:team1, :team2).where("team1_id = ? OR team2_id = ?", @team.id, @team.id).order(:start)
    @teams = [@officials.collect{|match| match.team1}, @officials.collect{|match| match.team2}]
  end

  def create
    @team = Official::Team.new(team_params)

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
