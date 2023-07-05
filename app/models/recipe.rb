class Recipe < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  acts_as_favoritable
  # has_many :ingredients, dependent: :destroy
  validates :title, presence: true
  validates :ingredients, presence: true
  validates :prep_time, presence: true
  validates :instructions, presence: true
  validates :url, presence: true

  include PgSearch::Model
  multisearchable against: [:title, :ingredients]
end
