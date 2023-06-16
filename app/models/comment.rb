class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  belongs_to :workout
  belongs_to :post
end
