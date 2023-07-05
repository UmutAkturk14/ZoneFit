class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    # ? We might want to change here after we've implemented `followability`
    @posts = @user.posts
    authorize @user
  end

  def edit
    if @user == record
      true
    else
      false
    end
  end

  def message
    @recipient = User.find(params[:id])
    authorize current_user
    @chat = if PrivateChatroom.where(creator: @recipient, joiner: current_user).first.nil?
              PrivateChatroom.where(creator: current_user, joiner: @recipient)
            else
              PrivateChatroom.where(creator: @recipient, joiner: current_user)
            end
    unless @chat.first.nil?
      redirect_to private_chatroom_path(@chat.first)
    else
      PrivateChatroom.create!(creator: current_user, joiner: @recipient)
      redirect_to private_chatroom_path(PrivateChatroom.last)
    end
  end
end
