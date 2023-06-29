class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :workouts
  has_many :recipes
  has_many :posts
  has_many :comments, through: :posts
  has_one_attached :photo
  has_one_attached :banner

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
