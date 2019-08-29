class Team < ApplicationRecord
  has_one_attached :pic
  attr_accessor :COUNTRIES
  has_many :eventteams
  has_many :events, through: :eventteams
  has_many :players
  has_many :officials
  before_save :get_image, if: :logo?
  serialize :socials
  validates :name, presence: true
  validates :country, presence: true

  def self.update_teams(win, lose, time_played)
    winner, loser = Team.find(win), Team.find(lose)
    #Update Streak
    winner_streak = winner.streak
    loser_streak = loser.streak

    if winner_streak > 0
      winner.streak += 1
    else
      winner.streak = 1
    end

    if loser_streak < 0
      loser.streak -= 1
    else
      loser.streak = -1
    end
    #Update Rating
    rating1, rating2 = ApplicationController.helpers.elo_rating?(winner.rating, loser.rating, 30)
    winner.rating = rating1
    loser.rating = rating2

    #Update Games Played
    winner.games_played += 1
    loser.games_played += 1

    winner.last_played = time_played
    loser.last_played = time_played

    #save
    winner.save!
    loser.save!
  end

  def get_image
    image = open(self.logo)
    self.pic.attach(io: image, filename: self.name+".png")
  end
end
