require 'open-uri'

class Player < ApplicationRecord
  has_one_attached :avatar
  before_save :get_image, if: :headshot?
  before_save :record_team, if: :will_save_change_to_team_id?
  before_create :set_default_image
  has_many :performances
  has_many :maps, :through => :performances
  belongs_to :team
  serialize :nicknames
  serialize :socials
  serialize :past_teams
  validates :eng_name, presence: true
  validates :handle, presence: true
  validates :country, presence: true
  validates :roles, presence: true
  after_create :lazy_starter

  def get_image
    image = open(self.headshot)
    self.avatar.attach(io: image, filename: self.handle+"-"+self.eng_name+".png")
  end

  def set_default_image
    unless self.avatar.attached?
      self.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'misc', 'default-player.png')), filename: 'default-player.png', content_type: 'image/png')
    end
  end

  def record_team
    if self.past_teams.nil?
      self.past_teams = [self.team_id]
    else
      self.past_teams << self.team_id
    end
  end

  def lazy_starter
    if self.team.players.where(roles: self.roles).length < 3
      self.starter = true
      self.save!
    end
  end
end
