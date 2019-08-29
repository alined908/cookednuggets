class Map < ApplicationRecord
  has_many :performances
  has_many :players, :through => :performances
  belongs_to :official
  belongs_to :winner, class_name: 'Team', foreign_key: 'winner_id', optional: true
  before_save :set_match_score, if: :will_save_change_to_winner_id?
  serialize :score
  validates :state, presence: true

  def self.get_perfs(maps, teams)
    ids = [teams[0].id, teams[1].id]

    maps_json = maps.includes(performances: :player).map do |map|
      performances = [map.performances.reject{|play| play.team_id != ids[0]}.collect {|perf| perf.player}, map.performances.reject{|play| play.team_id != ids[1]}.collect {|perf| perf.player}]
      if performances[0].empty?
        map.as_json.merge({players: [Team.find(ids[0]).players.where(starter: true).limit(6), Team.find(ids[1]).players.where(starter: true).limit(6)]})
      else
        map.as_json.merge({players: [performances[0], performances[1]]})
      end
    end
    return maps_json
  end

  def set_match_score
    winner = self.winner_id
    official = Official.find(self.official_id)
    if official.identifier.nil?
      official.update_score(winner)
    end
  end
end
