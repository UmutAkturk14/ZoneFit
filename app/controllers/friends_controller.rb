class FriendsController < ApplicationController
  def index
    @f = policy_scope(User)
    @user = current_user
    authorize @user
    # TODO: Pending friend requests for the user
    # @pending_requests = @user.follow_requests
    @pending_requests = @user.follow_requests
    console
    # TODO: Pending friend requests sent
    @pending_requests_sent = @user.pending_requests
    # TODO: All friends
  end
end
