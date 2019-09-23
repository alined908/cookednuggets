class Officials::TeamsController < ApplicationController
  before_action :set_team, only: [:show, :new, :destroy, :edit, :update]
  before_action :set_info, only: [:index, :create]

  def index
  end

  def show
    @players = @team.players
    @officials = Official.where("team1_id = ? OR team2_id = ?", @team.id, @team.id).includes(:team1, :team2, :event, :section).order(start: :desc).paginate(:page => params[:page], :per_page => 15)
    @info = [@officials.collect{|match| match.team1}, @officials.collect{|match| match.team2}, @officials.collect{|match| match.event}, @officials.collect{|match| match.section}]
  end

  def create
    @team = Team.new(team_params)
    authorize @team
    if params[:players]
      params[:players].each do |player|
        plyr = Player.find(player.to_i)
        unless @team.players.include?(plyr)
          @team.players << plyr
        end
      end
    end
    @team.socials = team_params[:socials]

    if @team.save
      flash[:success] = "Team successfully created."
      redirect_to @team
    else
      flash.now[:danger] = @team.errors.full_messages
      render 'index'
    end

  end

  def update
    authorize @team
    if @team.update_attributes(team_params)
      flash[:success] = "Successfully updated Team"
    else
      flash[:danger] = "Unable to update Team. There is an error with a field."
    end
    redirect_to team_path(@team)
  end

  def destroy
    authorize @team
    name = @team.name
    @team.destroy
    flash[:success] = "Team '#{name}' successfully deleted."
    redirect_to teams_path
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def set_info
      @players = Player.all.order('LOWER(handle)')
      @teams, @team = Team.all, Team.new
      @events = Event.all
    end

    def team_params
      params.require(:team).permit(:name, :shortname, :website, :logo, :country, :streak, :winnings, :rating, :games_played, :last_played, :players, socials: [:TWITTER, :DISCORD, :YOUTUBE_CHANNEL, :FACEBOOK, :INSTAGRAM, :TWITCH])
    end
end
