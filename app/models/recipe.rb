class Recipe < ApplicationRecord
  belongs_to :user
  include PgSearch::Model
  multisearchable against: [:title, :ingredients]
end
