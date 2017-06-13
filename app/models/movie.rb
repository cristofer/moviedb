class Movie < ActiveRecord::Base
  validates :title, presence: true
  validates :text, presence: true
  has_and_belongs_to_many :categories
end
