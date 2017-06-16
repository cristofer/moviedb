class Movie < ActiveRecord::Base
  validates :title, presence: true
  validates :text, presence: true
  has_and_belongs_to_many :categories, uniq: true
  belongs_to :user
  has_many :ratings, dependent: :delete_all

  scope :search, -> (text) { where("title ILIKE ? OR text ILIKE ?", "%#{text}%", "%#{text}%").order(:title) }

  scope :search_by_category, -> (category) { joins(:categories).where( :categories => { :id => category } ).order(:title) }

  scope :search_by_rate, -> (rate) { joins(:ratings).where( :ratings => { :stars => rate } ).order(:title) }

  scope :list_all, -> { order(:title)}
end
