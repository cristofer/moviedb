module MoviesHelper
  def owner(movie)
    movie.user == current_user
  end
end
