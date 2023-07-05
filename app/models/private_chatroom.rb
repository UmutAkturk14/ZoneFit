class PrivateChatroom < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :joiner, class_name: "User", foreign_key: "joiner_id"
  has_many :private_messages

  validates :creator, uniqueness: { scope: :joiner }
end
