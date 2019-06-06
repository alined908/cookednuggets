class Match < ApplicationRecord
  belongs_to :user
  has_one :composition
  validates :date, presence: true
  validates :left_team, presence: true
  validates :right_team, presence: true
  validates :map, presence: true
  validates :user_id, presence: true
end
