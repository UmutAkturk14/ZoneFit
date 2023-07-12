class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    authorize @chatroom
    @message = Message.new
    @chatrooms = policy_scope(Chatroom)
    @private_chatrooms = policy_scope(PrivateChatroom)
    @chats = PrivateChatroom.where(creator_id: current_user.id) + PrivateChatroom.where(joiner_id: current_user.id)
    @chatroom.reset_notification_count
  end

  def index
    @chatrooms = policy_scope(Chatroom)
    @community = Chatroom.new
  end

  def create
    @community = Chatroom.new(chatroom_params)
    @community.user_id = current_user.id
    authorize @community
    if @community.save!
      flash[:notice] = "Congratulations! You have created your own gang!"
      redirect_back(fallback_location: root_path)
    else
      render :create, :unprocessable_entity
    end
  end

  def destroy
    @community = Chatroom.find(params[:id])
    if authorize @community
      Message.where(chatroom: @community).delete_all
    end

    if @community.destroy
      flash[:notice] = "Your community has been successfully removed. Your gang is now without a chieftain."
      redirect_back(fallback_location: root_path)
    end
  end

  def notifications_count
    chatroom = Chatroom.find_by_id(params[:id])
    if chatroom.nil?
      render json: { error: "Chatroom not found" }, status: :not_found
    else
      authorize chatroom, :notifications_count?
      count = chatroom.notifications_count
      render json: { count: count }
    end
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:name, :description, :photo)
  end
end
