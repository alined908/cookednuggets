class Event < ApplicationRecord
  has_many :eventteams
  has_many :teams, through: :eventteams
  validates :name, presence: true
  validates :location, presence: true
  validates :prize, presence: true
  validates :start_date, presence: true
end
