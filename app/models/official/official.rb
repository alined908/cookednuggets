class Official < ApplicationRecord
  belongs_to :section
  belongs_to :team1, class_name: 'Team', foreign_key: 'team1_id'
  belongs_to :team2, class_name: 'Team', foreign_key: 'team2_id'
  belongs_to :winner, class_name: 'Team', foreign_key: 'winner_id', optional: true
  serialize :score
  has_many :maps
  validates :start, presence: true
  validates :end, presence: true
end
