class Match < ApplicationRecord
  belongs_to :user
  validates :date, presence: true
  validates :opponent, presence: true
  validates :map, presence: true
  validates :user_id, presence: true
end
