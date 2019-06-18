class ForumPost < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :forum_posts, as: :commentable
  validates :body, presence: true
end
