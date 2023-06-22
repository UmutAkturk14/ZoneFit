class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def edit
    authorize @user
    # if @user == record.user
    #   true
    # else
    #   false
    # end
  end
end
