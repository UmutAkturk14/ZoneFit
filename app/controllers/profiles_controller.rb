class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def edit
    if @user == record
      true
    else
      false
    end
  end
end
