class Category < ActiveRecord::Base
  validates :name, uniqueness: true
  has_and_belongs_to_many :movies

  scope :with_movies, -> { joins(:movies).distinct }

  def to_s
    name
  end

  def movies_count
    name + "(" + movies.count.to_s + ")"
  end
end
