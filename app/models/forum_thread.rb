include ActionView::Helpers::DateHelper

class ForumThread < ApplicationRecord
  belongs_to :user
  has_many :forum_posts, as: :commentable
  validates :subject, presence: true
  validates :description, presence: true

  def self.info(threads, count)
    thread_info = []
    threads.each {|thread|
      entry = []
      thread_posts = ForumPost.where(commentable: thread)
      thread_posts[-1].nil? ? (last_activity = thread.created_at) : (last_activity = thread_posts[-1].created_at)
      entry.push(time_ago_in_words(last_activity.to_time).gsub("about", "").gsub("less than a", "1"))
      entry.push(thread.user.username.capitalize)
      if count
        post_count = total_post_count(thread)
        entry.push(post_count)
      end
      thread_info.push(entry)
    }
    return thread_info
  end
end

def total_post_count(thread)
  commentable = ForumPost.where(commentable: thread)
  count = commentable.length
  commentable.each {|post| count += total_post_count(post)}
  return count
end
