class Section < ApplicationRecord
  belongs_to :event
  has_many :officials
  validates :name, presence: true
  validates :start, presence: true
end
