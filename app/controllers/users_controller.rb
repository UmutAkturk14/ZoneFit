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

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(user_params)
      flash[:notice] = "Your profile has been updated"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :bio, :nickname, :photo, :banner)
  end
end
