class Official < ApplicationRecord
  belongs_to :events
  has_one :team1, class_name: 'Team', foreign_key: 'team1_id'
  has_one :team2, class_name: 'Team', foreign_key: 'team2_id'
  validates :datetime, presence: true
end
