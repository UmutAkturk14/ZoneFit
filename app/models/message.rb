class Message < ApplicationRecord
  belongs_to :chatroom, counter_cache: true
  belongs_to :user

  after_create_commit :increment_notification_count

  def sender?(a_user)
    user.id == a_user.id
  end

  private

  def increment_notification_count
    chatroom.increment!(:notifications_count)
  end
end
