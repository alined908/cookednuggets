require 'open-uri'

class Player < ApplicationRecord
  has_one_attached :avatar
  before_save :get_image, if: :headshot?
  has_many :performances
  has_many :maps, :through => :performances
  belongs_to :team
  serialize :nicknames
  serialize :socials
  validates :eng_name, presence: true
  validates :handle, presence: true
  validates :country, presence: true
  validates :roles, presence: true

  def get_image
    image = open(self.headshot)
    self.avatar.attach(io: image, filename: self.handle+"-"+self.eng_name+".png")
  end
end
