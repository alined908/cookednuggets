class Official < ApplicationRecord
  belongs_to :section
  belongs_to :event
  belongs_to :team1, class_name: 'Team', foreign_key: 'team1_id'
  belongs_to :team2, class_name: 'Team', foreign_key: 'team2_id'
  belongs_to :winner, class_name: 'Team', foreign_key: 'winner_id', optional: true
  before_save :callback_teams, if: :will_save_change_to_winner_id?
  after_create :default_maps
  after_create :give_title
  has_many :forum_posts, as: :commentable
  serialize :score
  has_many :maps
  has_many :performances, :through => :maps
  validates :start, presence: true
  validates :end, presence: true

  def self.h2hs(teams, id)
    team1, team2 = teams[0], teams[1]
    h2hs = Official.where(team1: team1, team2: team2).or(Official.where(team1: team2, team2: team1)).where.not(winner_id: nil, id: id).order(start: :desc).includes(:team1, :team2, section: :event)
    return reverse_matches(team1, h2hs)
  end

  def self.recents(teams, id)
    team1, team2 = teams[0], teams[1]
    team1_recents, team2_recents = recents_helper(team1, id), recents_helper(team2, id)
    return [team1_recents, team2_recents]
  end

  def self.recents_helper(team, id)
    recents = Official.where("(team1_id = ? OR team2_id = ?) AND id != ?", team.id, team.id, id).where.not(winner_id: nil).order(start: :desc).includes(team1: [pic_attachment: :blob], team2: [pic_attachment: :blob]).limit(5)
    return reverse_matches(team, recents)
  end

  def self.reverse_matches(team, recents)
    recents.each do |recent|
      if team != recent.team1
        recent.score.reverse!
        hello = recent.team1
        recent.team1 = recent.team2
        recent.team2 = hello
      end
    end
    return recents
  end

  def update_score(winner)
    if winner == self.team1.id
      self.score[0] += 1
    else
      self.score[1] += 1
    end
    self.save!
  end

  private

  def give_title
    title = self.team1.shortname + " vs " + self.team2.shortname + " - " + self.event.name + " " + self.section.name
    self.subject = title
    self.save!
  end

  def callback_teams
    winner = self.winner_id
    loser = ((self.team1_id == winner) ? self.team2_id : self.team1_id)
    Team.update_teams(winner, loser, self.end)
  end

  def default_maps
    if self.identifier.nil?
      for i in 0..(self.map_count-1)
        self.maps << Map.create(official_id: self.id, winner_id: nil, score: [0, 0], name: nil, state: "unfinished")
      end
    end
  end
end
