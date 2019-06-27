class Match < ApplicationRecord
  belongs_to :user
  has_one :composition
  has_one :general
  has_one :fight
  validates :date, presence: true
  validates :left_team, presence: true
  validates :right_team, presence: true
  validates :map, presence: true
  validates :user_id, presence: true
end
