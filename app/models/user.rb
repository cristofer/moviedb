class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :ratings, dependent: :delete_all
  has_many :movies, dependent: :destroy
  after_create :generate_api_key

  def generate_api_key
    self.update_column(:api_key, SecureRandom.hex(16))
  end

  def to_s
    email
  end
end
