class Comment < ActiveRecord::Base
  belongs_to :movie
  belongs_to :author, class_name: "User"

  validates :text, presence: true

  scope :persisted, lambda { where.not(id: nil) }
end
