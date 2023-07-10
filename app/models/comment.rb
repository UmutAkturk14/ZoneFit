class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :content, presence: true
  validates :user, presence: true
  has_noticed_notifications

  after_create_commit :notify_commentable_user

  private

  def notify_commentable_user
    AppNotification.with(comment: self).deliver_later(commentable.user)
  end
end
