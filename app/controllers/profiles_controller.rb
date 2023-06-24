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
end
