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

  def active_vote?(post, current_user)
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
end
