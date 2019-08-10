class New < ApplicationRecord
  mount_uploaders :pictures, CkeditorPictureUploader
  serialize :avatars, JSON
  belongs_to :user
  has_many :forum_posts, as: :commentable
  validates :subject, presence: true
end
