class Workout < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  acts_as_favoritable

  include PgSearch::Model
  multisearchable against: [:title, :muscle_group, :description, :tag]
end
