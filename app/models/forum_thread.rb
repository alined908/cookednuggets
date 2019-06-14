include ActionView::Helpers::DateHelper

class ForumThread < ApplicationRecord
  belongs_to :user
  has_many :forum_posts
  validates :subject, presence: true
  validates :description, presence: true

  def self.info(threads)
    thread_info = []
    threads.each {|thread|
      entry = []
      entry.push(time_ago_in_words(thread.created_at.to_time))
      entry.push(thread.user.username)
      thread_info.push(entry)
    }
    return thread_info
  end

end
