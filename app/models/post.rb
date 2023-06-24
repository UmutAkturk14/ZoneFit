class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable

  validates :content, presence: true
  validates :user, presence: true
end
