class PrivateMessage < ApplicationRecord
  belongs_to :private_chatroom
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"
end
