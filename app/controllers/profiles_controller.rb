class ProfilesController < ApplicationController
  before_action :set_user, only: [:friend, :unfriend, :show, :accept, :decline, :cancel]

  def show
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

  def friend
    authorize current_user
    if current_user.send_follow_request_to(@user)
      flash[:notice] = "Friendship request sent to #{@user.first_name}"
      redirect_back(fallback_location: root_path)
    end
  end

  def unfriend
    authorize current_user
    if current_user.unfollow(@user)
      @user.unfollow(current_user)
      flash[:notice] = "You are not friends with #{@user.first_name} anymore."
      redirect_back(fallback_location: root_path)
    end
  end

  def accept
    authorize current_user
    if current_user.accept_follow_request_of(@user)
      current_user.send_follow_request_to(@user)
      @user.accept_follow_request_of(current_user)
      flash[:notice] = "You are now friends with #{@user.first_name}! 🎉🎉"
      redirect_back(fallback_location: root_path)
    end
  end

  def decline
    authorize current_user
    if current_user.decline_follow_request_of(@user)
      flash[:notice] = "You declined the friendship request of #{@user.first_name}. Not so friendly, eh? 🤨"
      redirect_back(fallback_location: root_path)
    end
  end

  def cancel
    authorize current_user
    if current_user.remove_follow_request_for(@user)
      flash[:notice] = "You have successfully reoved your friendship request for #{@user.first_name}."
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
