class PrivateChat < ApplicationRecord
  belongs_to :sender
  belongs_to :recipient

  has_many :messages
  validates :creator, presence: true
  validates :joiner, presence: true
end
