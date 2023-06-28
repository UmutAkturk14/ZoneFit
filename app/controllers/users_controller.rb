class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    # ? We might want to change here after we've implemented `followability`
    @posts = @user.posts.order("created_at DESC")
    @post = Post.new
    @post.user = @user
    authorize @user
    @users = User.all
    # The `geocoded` scope filters only flats with coordinates
    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude
      }
    end
    # @markers =
    #   {
    #     lat: @user.latitude,
    #     lng: @user.longitude
    #   }
      # @markers = @user.geocoded.map do |user|
      #   {
      #     lat: user.latitude,
      #     lng: user.longitude
      #   }
      # end
  end

  def edit
    authorize @user
  end
end
