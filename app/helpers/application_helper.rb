module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Moviedb").join(" - ")
      end
    end
  end
end
