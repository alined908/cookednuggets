class Officials::PlayersController < ApplicationController
  before_action :set_player, only: [:show, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @teams = Team.all
    @player = Player.new
    @players = Player.includes(:team).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @teams = Team.all
    @player.past_teams.nil? ? @past_teams = [] : @past_teams = @player.past_teams.reverse.map {|team| Team.find(team)}
    @recent_matches = Official.joins(:performances => :map).where(:performances => {:player => @player}).distinct.order(start: :desc).paginate(:page => params[:page], :per_page => 20).includes(:team1, :team2, :event, :section)
  end

  def create
    @player = Player.new(player_params)
    authorize @player
    @player.socials = player_params[:socials]

    if @player.save
      flash[:success] = "Player successfully created"
      redirect_to @player
    else
      flash[:danger] = @player.errors.full_messages
      redirect_to players_path
    end
  end

  def update
    authorize @player
    if @player.update_attributes(player_params)
      flash[:success] = "Successfully updated Player"
    else
      flash[:danger] = "Unable to update Player. There is an error with a field."
    end
    redirect_to player_path(@player)
  end

  def destroy
    authorize @player
    @player.destroy
    flash[:success] = "Player successfully deleted."
    redirect_to players_path
  end

  private

    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:starter, :headshot, :eng_name, :nat_name, :nicknames, :handle, :country, :age, :roles, :team_id, :past_teams, socials: [:TWITTER, :DISCORD, :YOUTUBE_CHANNEL, :FACEBOOK, :INSTAGRAM, :TWITCH])
    end

  def sort_column
    Player.column_names.include?(params[:sort]) ? (column = params[:sort]) : (column = "LOWER(handle)")

    if !params[:sort].nil? && (params[:sort].include? ("."))
      column = params[:sort]
    end

    return column
  end

  def sort_direction
    %w[asc desc].include?(params[:d]) ? params[:d] : "asc"
  end

end
