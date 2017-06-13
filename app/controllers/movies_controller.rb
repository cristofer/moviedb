class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :check_permissions, only: [:edit, :update, :destroy]

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user

    if @movie.save
      flash[:notice] = "Movie has been created."
      redirect_to @movie
    else
      flash.now[:alert] = "Movie has not been created."
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      flash[:notice] = "Movie has been updated."
      redirect_to @movie
    else
      flash.now[:alert] = "Movie has not been updated."
      render "edit"
    end
  end

  def destroy
    @movie.destroy

    flash[:notice] = "Movie has been deleted."
    redirect_to movies_path
  end

  private
    
    def movie_params
      params.require(:movie).permit(:title, :text, category_ids: [])
    end

    def set_movie
      @movie = Movie.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The movie you were looking for could not be found."
      redirect_to movies_path
    end

    def check_permissions
      begin
        if current_user != @movie.user
          raise "unauthorized"
        end 
      rescue
          flash[:alert] = "You are not allowed to do that."
          redirect_to root_path
      end
    end
end
