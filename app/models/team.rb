class Team < ApplicationRecord
  attr_accessor :COUNTRIES
  has_many :eventteams
  has_many :events, through: :eventteams
  has_many :players
  serialize :socials
  validates :name, presence: true
  validates :country, presence: true

end
