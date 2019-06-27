class Player < ApplicationRecord
  belongs_to :team
  serialize :nicknames
  serialize :roles
  serialize :socials
  validates :eng_name, presence: true
  validates :handle, presence: true
  validates :country, presence: true
  validates :roles, presence: true
end
