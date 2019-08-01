module ApplicationHelper
  def current_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end

  def disc_path?(disc)
    type = disc.class
    if type == Official
      return [match_path(disc), "type-match"]
    elsif type == New
      return [news_path(disc), "type-news"]
    else
      return [thread_path(disc), "type-forum"]
    end
  end
end
