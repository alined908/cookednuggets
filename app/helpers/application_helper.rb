module ApplicationHelper
  def current_class?(test_path)
    request.path == test_path ? "active" : ""
  end

  def disc_path?(disc)
    type = disc.class
    if type == Official
      return [match_path(disc), "type-match", "Matches", threads_path(:f => "matches")]
    elsif type == New
      return [news_path(disc), "type-news", "News",threads_path(:f => "news") ]
    else
      return [thread_path(disc), "type-forum", "Discussions",threads_path(:f => "threads") ]
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

  def probability?(rating1, rating2)
    return 1.0 / ( 1.0 + ( 10.0 ** ((rating1.to_f - rating2.to_f) / 400.0) ) )
  end

  def elo_rating?(rating1, rating2, k)
    prob_1 = probability?(rating2, rating1)
    prob_2 = probability?(rating1, rating2)

    rating1 = rating1 + k * (1 - prob_1)
    rating2 = rating2 + k * (0 - prob_2)

    return rating1, rating2
  end

  def sortable(column, title=nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :d => direction}, {:class => css_class}
  end

  def streak_helper?(streak)
    if streak < 0
      return [-streak, "L"]
    elsif streak > 0
      return [streak, "W"]
    else
      return [streak, ""]
    end
  end

  def get_time_ago(time)
    time_ago = time_ago_in_words(time.to_time).gsub("about", "").gsub("less than a", "1")
    return time_ago
  end

  def get_time_string(time)
    return time.strftime("%Y-%m-%d %H:%M")
  end
end
