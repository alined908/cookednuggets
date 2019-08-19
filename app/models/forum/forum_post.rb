class ForumPost < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :forum_posts, as: :commentable
  has_many :votes, as: :votable, dependent: :destroy
  after_create -> (x) {update_count(1)}
  before_destroy -> (x) {update_count(-1)}
  validates :body, presence: true

  def update_count(num)
    parent = self.find_parent
    parent.comments_count += num
    parent.save!
  end

  def find_parent
    parent = self.commentable
    while parent.is_a? ForumPost
      parent = parent.commentable
    end
    return parent
  end
end
