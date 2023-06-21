class Recipe < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable

  include PgSearch::Model
  multisearchable against: [:title, :ingredients]
end
