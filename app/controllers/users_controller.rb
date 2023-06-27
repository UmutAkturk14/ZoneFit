class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # ? We might want to change here after we've implemented `followability`
    @posts = @user.posts.order("created_at DESC")
    @post = Post.new
    @post.user = @user
    authorize @user
    @markers =
      {
        lat: @user.latitude,
        lng: @user.longitude
      }
      # @markers = @user.geocoded.map do |user|
      #   {
      #     lat: user.latitude,
      #     lng: user.longitude
      #   }
      # end
  end

  def edit
    @user = current_user
    authorize @user
  end
end
