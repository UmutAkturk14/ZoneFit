class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  followability
  has_many :workouts, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts, dependent: :destroy
  has_many :private_chatrooms
  has_one_attached :photo, dependent: :destroy
  has_one_attached :banner, dependent: :destroy
  acts_as_favoritor

  validates :first_name, presence: true
  validates :last_name, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
