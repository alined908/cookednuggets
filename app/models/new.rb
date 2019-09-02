class New < ApplicationRecord
  has_one_attached :avatar
  mount_uploaders :pictures, CkeditorPictureUploader
  serialize :pictures, JSON
  belongs_to :user
  has_many :forum_posts, as: :commentable
  validates :subject, presence: true
end
