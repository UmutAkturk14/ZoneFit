class Chatroom < ApplicationRecord
  has_many :messages
  has_one_attached :photo

  def reset_notification_count
    update(notifications_count: 0)
  end
end
