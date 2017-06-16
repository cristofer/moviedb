class API::MoviesController < API::ApplicationController
  before_action :authenticate_user!, :except => [:show, :create]
  before_action :set_movie, :only => [:show]

  def show
    render json: @movie
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      render json: @movie, status: 201
    else
      render json: {errors: @movie.errors.full_messages}, status: 422
    end
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :text)
    end
end
