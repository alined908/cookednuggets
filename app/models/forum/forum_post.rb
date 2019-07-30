class ForumPost < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :forum_posts, as: :commentable
  after_create -> (x) {update_count(1)}
  after_destroy -> (x) {update_count(-1)}
  validates :body, presence: true

  def update_count(num)
    parent = self.commentable
    while parent.is_a? ForumPost
      parent = parent.commentable
    end
    parent.comments_count += num
    parent.save!
  end
end
