class MoviesController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show, :search, :search_by_category, :search_by_rate]
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :rate]
  before_action :check_edit_permissions, only: [:edit, :update, :destroy, :rate]
  before_action :check_logged, only: [:new, :create, :rate]

  def index
    @movies = Movie.page(params[:page]).per(10)
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

  def rate
    stars = params[:rate]

    if !@movie.ratings.exists?(user: current_user)
      if @movie.ratings.create!(user: current_user, stars: stars)
        head :ok
      end
    else
      if @movie.ratings.find_by(user: current_user).update!(stars: stars)
        head :ok
      end
    end

    head :ok
  end

  def search
    text = params[:search]

    text.gsub!(" ", "%") if text.match(" ")

    @movies = Movie.search text

    respond_to do |format|
      format.js { render "search.js.erb", locals: { movies: @movies } }
    end
  end

  def search_by_category
    category = params[:search]

    @movies = Movie.search_by_category category

    respond_to do |format|
      format.js { render "search.js.erb", locals: { movies: @movies } }
    end
  end

  def search_by_rate
    rate = params[:search]

    @movies = Movie.search_by_rate rate

    respond_to do |format|
      format.js { render "search.js.erb", locals: { movies: @movies } }
    end
  end

  private
    def movie_params
      params.require(:movie).permit(:title, :text, category_ids: [])
    end

    def rate_params
      params.permit(:id, :rate)
    end

    def set_movie
      @movie = Movie.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The movie you were looking for could not be found."
      redirect_to movies_path
    end

    def check_edit_permissions
      begin
        if current_user.blank? || current_user != @movie.user
          raise "unauthorized"
        end 
      rescue
          flash[:alert] = "You are not allowed to do that."
          redirect_to root_path
      end
    end
     
    def check_logged
      begin
        if current_user.blank?
          raise "unauthorized"
        end 
      rescue
          flash[:alert] = "You are not allowed to do that."
          redirect_to root_path
      end
    end
end
