class MoviesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show search search_by_category search_by_rate rate_by_amount]
  before_action :set_movie, only: %i[show edit update destroy rate rate_by_amount]

  helper StatisticsHelper

  def index
    @movies = Movie.list_all.page(params[:page]).per(10)
  end

  def new
    @movie = Movie.new
    authorize @movie, :create?
  end

  def create
    @movie = Movie.new(movie_params)
    authorize @movie, :create?

    @movie.user = current_user

    if @movie.save
      flash[:notice] = 'Movie has been created.'
      redirect_to @movie
    else
      flash.now[:alert] = 'Movie has not been created.'
      render 'new'
    end
  end

  def show
    authorize @movie, :show?
    @comment = @movie.comments.build
  end

  def edit
    authorize @movie, :update?
  end

  def update
    authorize @movie, :update?

    if @movie.update(movie_params)
      flash[:notice] = 'Movie has been updated.'
      redirect_to @movie
    else
      flash.now[:alert] = 'Movie has not been updated.'
      render 'edit'
    end
  end

  def destroy
    authorize @movie, :destroy?

    @movie.destroy

    @movies = Movie.list_all

    flash.now[:notice] = 'Movie has been deleted.'

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def rate
    authorize @movie, :rate?

    stars = params[:rate]

    Rating.set_rating(current_user, @movie, stars)

    respond_to do |format|
      format.js { render 'stars.js.erb', locals: { id: @movie.id } }
    end
  end

  def rate_by_amount
    authorize @movie, :rate_by_amount?

    result = @movie.ratings.group(:stars).count

    render json: [{ name: 'Rates', data: result }]
  end

  def search
    text = params[:search]

    text.gsub!(/\s+/, '%')

    @movies = Movie.search text

    authorize @movies, :search?

    respond_to do |format|
      format.js { render 'search.js.erb', locals: { movies: @movies } }
    end
  end

  def search_by_category
    category = params[:search]

    @movies = Movie.search_by_category category

    authorize @movies, :search?

    respond_to do |format|
      format.js { render 'search.js.erb', locals: { movies: @movies } }
    end
  end

  def search_by_rate
    rate = params[:search]

    @movies = Movie.search_by_rate rate

    authorize @movies, :search?

    respond_to do |format|
      format.js { render 'search.js.erb', locals: { movies: @movies } }
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :text, :picture, :picture_cache, category_ids: [])
  end

  def rate_params
    params.permit(:id, :rate)
  end

  def set_movie
    @movie = Movie.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'The movie you were looking for could not be found.'
    redirect_to movies_path
  end
end
