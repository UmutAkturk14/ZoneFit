class Workout < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  acts_as_favoritable

  include PgSearch::Model
  multisearchable against: [:title, :muscle_group, :description, :tag]

  include PgSearch::Model
  pg_search_scope :search_by_title_and_description_and_tag,
    against: [:title, :muscle_group, :description, :tag],
    using: {
      tsearch: { prefix: true }
   }
end
