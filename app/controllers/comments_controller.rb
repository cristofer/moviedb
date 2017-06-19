class CommentsController < ApplicationController
  before_action :set_movie

  def create
    @comment = @movie.comments.build(comment_params)
    @comment.author = current_user
    authorize @comment, :create?

    if @comment.save
      flash[:notice] = "Comment has been created."
      redirect_to @movie
    else
      flash.now[:alert] = "Comment has not been created."
      render "movies/show"
    end
  end

  private

    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    def comment_params
      params.require(:comment).permit(:text)
    end
end
