class Map < ApplicationRecord
  has_many :performances
  has_many :players, :through => :performances
  belongs_to :official
  belongs_to :winner, class_name: 'Team', foreign_key: 'winner_id', optional: true
  before_save :set_match_score, if: :will_save_change_to_winner_id?
  after_create :create_performances
  serialize :score
  validates :state, presence: true

  def self.get_perfs(maps, teams)
    ids = [teams[0].id, teams[1].id]

    maps_json = maps.includes(performances: :player).map do |map|
      performances = [map.performances.reject{|play| play.team_id != ids[0]}.collect {|perf| perf.player}, map.performances.reject{|play| play.team_id != ids[1]}.collect {|perf| perf.player}]
      if performances[0].empty?
        map.as_json.merge({players: [Team.find(ids[0]).players.where(starter: true).limit(6).order(roles: :desc), Team.find(ids[1]).players.where(starter: true).limit(6).order(roles: :desc)]})
      else
        map.as_json.merge({players: [performances[0].sort_by(&:roles), performances[1].sort_by(&:roles)]})
      end
    end
    return maps_json
  end

  def def_players(players)
    return if players == nil
    players = players.map{|num| num.to_i}
    current_players = self.players.pluck(:id)
    put_on_bench = current_players - players
    put_in_game = players - current_players

    put_on_bench.each_with_index do |p, index|
      Performance.find_by(map_id: self.id, player_id: p).update(player_id: put_in_game[index])
    end
  end

  def set_match_score
    winner = self.winner_id
    official = Official.find(self.official_id)
    if official.identifier.nil?
      official.update_score(winner)
    end
  end

  def team1_perfs
    return self.performances.where(team_id: self.official.team1_id)
  end

  def team2_perfs
    return self.performances.where(team_id: self.official.team2_id)
  end

  def create_performances
    official = Official.find(self.official_id)
    team1, team2 = official.team1, official.team2
    if official.identifier.nil?
      team1.players.where(starter: true).each do |player|
        Performance.create(player_id: player.id, map_id: self.id, team_id: team1.id)
      end
      team2.players.where(starter: true).each do |player|
        Performance.create(player_id: player.id, map_id: self.id, team_id: team2.id)
      end
    end
  end
end
