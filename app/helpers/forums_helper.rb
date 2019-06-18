module ForumsHelper
  def get_time_ago(time)
    time_ago = time_ago_in_words(time.to_time).gsub("about", "").gsub("less than a", "1")
    return time_ago
  end

  def get_time_string(time)
    return time.strftime("%Y-%m-%d %H:%M")
  end
end
