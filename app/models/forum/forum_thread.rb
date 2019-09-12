include ActionView::Helpers::DateHelper

class ForumThread < ApplicationRecord
  belongs_to :user
  has_many :forum_posts, as: :commentable,  dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  validates :subject, presence: true
  validates :description, presence: true
end
