class New < ApplicationRecord
  belongs_to :user
  has_many :forum_posts, as: :commentable
  validates :subject, presence: true
  validates :article, presence: true
end
