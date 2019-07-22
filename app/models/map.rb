class Map < ApplicationRecord
  has_many :performances
  has_many :players, :through => :performances
  belongs_to :official
  belongs_to :winner, class_name: 'Team', foreign_key: 'winner_id', optional: true
  serialize :score
  validates :state, presence: true
end
