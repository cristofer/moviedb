class Movie < ActiveRecord::Base
  validates :title, presence: true
  validates :text, presence: true
  has_and_belongs_to_many :categories, uniq: true
  belongs_to :user
  has_many :ratings, dependent: :delete_all
end
