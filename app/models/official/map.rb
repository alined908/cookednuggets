class Official::Map < ApplicationRecord
  belongs_to :official
  belongs_to :winner, class_name: 'Team', foreign_key: 'winner_id', optional: true
  serialize :score
  validates :state, presence: true
end
