class Workout < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable

  include PgSearch::Model
  multisearchable against: [:title, :muscle_group, :description, :tag]
end
