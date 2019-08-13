class Officials::TeamsController < ApplicationController
  before_action :set_team, only: [:show, :new, :destroy, :edit]

  def index
    @teams, @team = Team.all, Team.new
    @events = Event.all
  end

  def show
    @players = @team.players
    @officials = Official.where("team1_id = ? OR team2_id = ?", @team.id, @team.id).includes(:team1, :team2, :event, :section).order(start: :desc).paginate(:page => params[:page], :per_page => 15)
    @info = [@officials.collect{|match| match.team1}, @officials.collect{|match| match.team2}, @officials.collect{|match| match.event}, @officials.collect{|match| match.section}]
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
