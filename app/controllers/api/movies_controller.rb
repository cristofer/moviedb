class API::MoviesController < API::ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, :only => [:destroy, :update]
  before_action :set_movie, :only => [:show, :destroy, :update]
  before_action :check_edit_permissions, :only => [:destroy, :update]

  def index
    @movies = Movie.list_all

    render json: { movies: @movies }
  end

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

  def destroy
    @movie.destroy

   render json: { message: "The movie was deleted" } 
  end

  def update
    if @movie.update(movie_params)
      render json: { message: "The movie was updated" }
    else
      render json: { error: "The movie was not updated" }, status: 400
    end
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :text)
    end

    def check_edit_permissions
      if @current_user.blank? || @current_user != @movie.user
        render json: { error: "Unauthorized"}, status: 401
        return
      end 
    end
end
