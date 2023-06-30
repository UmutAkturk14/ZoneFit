class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_one_attached :attachment

  validates :content, presence: true
  validates :user, presence: true
end
