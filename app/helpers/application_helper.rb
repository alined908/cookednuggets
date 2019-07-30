module ApplicationHelper
  def current_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end

  def disc_path?(disc)
    puts disc.class
    if disc.class != Official
      return thread_path(disc)
    else
      return match_path(disc)
    end
  end
end
