class Workout < ApplicationRecord
  belongs_to :user

  include PgSearch::Model
  multisearchable against: [:title, :muscle_group, :description, :tag]
end
