class Team1 < ApplicationRecord
  has_many :eventteams
  has_many :events, through: :eventteams
  has_many :players
  serialize :socials
  validates :name, presence: true
  validates :country, presence: true

  COUNTRIES = {'South Korea':'kr', 'United States': 'us', 'France': 'fr', 'United Kingdom': 'uk',
              'China': 'cn', 'Canada': 'ca', 'Russia': 'ru'}
end
