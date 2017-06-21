class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  validates :user_id, uniqueness: { :scope => :movie_id, :message => "You already rated this movie" }

  scope :with_stars, -> (rate) { where(stars: rate)}

  def self.set_rating(user, movie, stars)
    
    record = self.self_record(user, movie)

    unless record
      create(user: user, movie: movie, stars: stars)
      return
    end

    record.update_columns(stars: stars)
  end

  private

  def self.self_record(user, movie)
    find_by(user: user, movie: movie)
  end
end
