class PrivateChatroomsController < ApplicationController
  before_action :set_chat, only: [:show]

  def index
    @private_chatrooms = policy_scope(PrivateChatroom)
    @chats = PrivateChatroom.where(creator_id: current_user.id) + PrivateChatroom.where(joiner_id: current_user.id)
    authorize @private_chatrooms
  end

  def show
    authorize @chat
    @message = PrivateMessage.new
    @chatrooms = policy_scope(Chatroom)
    @chats = PrivateChatroom.where(creator_id: current_user.id) + PrivateChatroom.where(joiner_id: current_user.id)
  end

  private

  def set_chat
    @chat = PrivateChatroom.find(params[:id])
  end
end
