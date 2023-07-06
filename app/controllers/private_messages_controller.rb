class PrivateMessagesController < ApplicationController
  def create
    @chatroom = PrivateChatroom.find(params[:private_chatroom_id])
    @message = PrivateMessage.new(message_params)
    @message.private_chatroom = @chatroom
    @message.sender = current_user
    @message.recipient = @chatroom.creator == current_user ? @chatroom.joiner : @chatroom.creator
    authorize @message
    @message.save
    PrivateChatroomChannel.broadcast_to(
      @chatroom,
      message: render_to_string(partial: "private_chatrooms/chat", locals: { message: @message }),
      sender_id: @message.sender.id
    )
    head :ok
  end

  private

  def message_params
    params.require(:private_message).permit(:content)
  end
end
