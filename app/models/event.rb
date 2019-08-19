class Event < ApplicationRecord
  has_one_attached :logo
  has_many :eventteams
  has_many :teams, through: :eventteams
  has_many :sections
  validates :name, presence: true
  validates :location, presence: true
  validates :prize, presence: true
  validates :start_date, presence: true
end
