class PrivateChatroomChannel < ApplicationCable::Channel
  def subscribed
    chatroom = PrivateChatroom.find(params[:id])
    stream_for chatroom
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
