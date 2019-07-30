module ApplicationHelper
  def current_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end

  def disc_path?(disc)
    type = disc.class
    if type == Official
      return match_path(disc)
    elsif type == New
      return news_path(disc)
    else
      return thread_path(disc)
    end
  end
end
