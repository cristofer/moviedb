class Movie < ActiveRecord::Base
  validates :title, presence: true
  validates :text, presence: true
end
