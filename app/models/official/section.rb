class Section < ApplicationRecord
  belongs_to :event
  has_many :officials
  validates :name, presence: true
  validates :start, presence: true

  def self.standings(teams, matches)
    standings = {}
    teams.each do |team|
      standings[team.name] = {'match': [0,0], 'map': [0, 0, 0]}
    end

    matches.each do |match|
      team1 = match.team1
      team2 = match.team2
      winner = match.winner
      if winner == team1
        standings[team1.name][:match][0] += 1
        standings[team2.name][:match][1] += 1
      else
        standings[team2.name][:match][0] += 1
        standings[team1.name][:match][1] += 1
      end
      match.maps.each do |map|
        winner = map.winner
        if winner == team1
          standings[team1.name][:map][0] += 1
          standings[team2.name][:map][1] += 1
        elsif winner == team2
          standings[team2.name][:map][0] += 1
          standings[team1.name][:map][1] += 1
        else
          standings[team2.name][:map][2] += 1
          standings[team1.name][:map][2] += 1
        end
      end
    end
    return standings
  end
end
