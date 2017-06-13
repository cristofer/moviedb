class Movie < ActiveRecord::Base
  validates :title, presence: true
  validates :text, presence: true
  has_and_belongs_to_many :categories, uniq: true
  belongs_to :user
  has_many :ratings, dependent: :delete_all

  scope :search, -> (text) { where("title ILIKE ? OR text ILIKE ?", "%#{text}%", "%#{text}%").order(:title) }
end
