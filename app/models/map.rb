class Map < ApplicationRecord
  has_many :performances
  has_many :players, :through => :performances
  belongs_to :official
  belongs_to :winner, class_name: 'Team', foreign_key: 'winner_id', optional: true
  serialize :score
  validates :state, presence: true

  def self.get_perfs(maps, teams)
    ids = [teams[0].id, teams[1].id]

    maps_json = maps.includes(performances: :player).map {|map|
      map.as_json.merge({players: [map.performances.reject{|play| play.team_id != ids[0]}.collect {|perf| perf.player},
        map.performances.reject{|play| play.team_id != ids[1]}.collect {|perf| perf.player}]
      })
    }

    return maps_json
  end
end
