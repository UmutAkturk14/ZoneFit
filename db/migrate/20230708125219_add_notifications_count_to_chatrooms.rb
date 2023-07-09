class AddNotificationsCountToChatrooms < ActiveRecord::Migration[7.0]
  def change
    add_column :chatrooms, :notifications_count, :integer
  end
end
