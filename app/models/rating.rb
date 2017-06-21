class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  validates :user_id, uniqueness: { scope: :movie_id, message: 'You already rated this movie' }

  scope :with_stars, ->(rate) { where(stars: rate) }

  def self.set_rating(user_, movie_, stars_)
    record = find_by(user: user_, movie: movie_)

    unless record
      create(user: user_, movie: movie_, stars: stars_)
      return
    end

    record.update_columns(stars: stars_)
  end
end
