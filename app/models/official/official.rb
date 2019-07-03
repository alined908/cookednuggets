class Official < ApplicationRecord
  belongs_to :section
  has_one :team1, class_name: 'Team', foreign_key: 'team1_id'
  has_one :team2, class_name: 'Team', foreign_key: 'team2_id'
  has_one :winner, class_name: 'Team', foreign_key: 'winner_id'
  serialize :score
  has_many :maps
  validates :start, presence: true
  validates :end, presence: true
end
