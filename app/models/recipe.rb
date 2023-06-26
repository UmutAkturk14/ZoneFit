class Recipe < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :ingredients, dependent: :destroy

  include PgSearch::Model
  multisearchable against: [:title, :ingredients]
end
