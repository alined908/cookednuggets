module ApplicationHelper
  def current_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end

  def disc_path?(disc)
    type = disc.class
    if type == Official
      return [match_path(disc), "type-match", "Officials"]
    elsif type == New
      return [news_path(disc), "type-news", "News"]
    else
      return [thread_path(disc), "type-forum", "Discussions"]
    end
  end

  def get_author(thread)
    type = thread.class
    if type == ForumThread or type == New
      return thread.user.username.capitalize
    elsif type == Official
      return ""
    end
  end

  def map_diff(diff)
    if diff == 0
      return ""
    elsif diff < 0
      return "negative"
    else
      return "positive"
    end
  end

  def active_vote?(post)
    if !user_signed_in?
      return ["", ""]
    end

    @prev_vote = post.votes.where(user_id: current_user.id)
    if @prev_vote.any?
      if @prev_vote[0].direction == 1
        ["positive", ""]
      else
        ["", "negative"]
      end
    else
      return ["", ""]
    end
  end

  def find_post_route?(post)
    parent = post.commentable
    type = parent.class

    if type == ForumThread
      return thread_post_path(thread_id: parent.id, id: post.id)
    elsif type == ForumPost
      return post_post_path(post_id: parent.id, id: post.id)
    elsif type == Official
      return match_post_path(match_id: parent.id, id: post.id)
    elsif type == New
      return news_post_path(news_id: parent.id, id: post.id)
    end
  end
end
