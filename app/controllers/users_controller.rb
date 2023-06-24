class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
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
    authorize @user
  end
end
