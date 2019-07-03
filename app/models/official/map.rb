class Map < ApplicationRecord
  belongs_to :official
  has_one :winner, class_name: 'Team', foreign_key: 'winner_id'
  serialize :score
  validates :state, presence: true
end
