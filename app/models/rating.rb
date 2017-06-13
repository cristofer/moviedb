class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  validates :user_id, uniqueness: { :scope => :movie_id, :message => "You already rated this movie" }
end
