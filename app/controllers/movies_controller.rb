class MoviesController < ApplicationController
  before_action :set_movie

  def index
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      flash[:notice] = "Movie has been created."
      redirect_to @movie
    else
      
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  private
    
    def movie_params
      params.require(:movie).permit(:name, :description)
    end

    def set_movie
#@movie = Movie.find(params[:id])
    end
end
