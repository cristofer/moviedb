module MoviesHelper
  def categories
    content_tag(:p) do
      value = "&#124;&nbsp;"
      Category.with_movies.each do |category|
        value += link_to category.movies_count, search_by_category_movies_path(search: category), remote: true
        value += "&nbsp;&#124;&nbsp;"
      end
      value.html_safe
    end
  end

  def stars
    content_tag(:p) do
      value = "&#124;&nbsp;"
      (1..5).each do |rate|
        rate_text = rate.to_s + " Stars (" + Rating.with_stars(rate).count.to_s + ")"
        value += link_to rate_text, search_by_rate_movies_path(search: rate), remote: true
        value += "&nbsp;&#124;&nbsp;"
      end
      value.html_safe
    end
  end
end
