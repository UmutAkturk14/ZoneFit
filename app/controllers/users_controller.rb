class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # ? We might want to change here after we've implemented `followability`
    @posts = @user.posts.order("created_at DESC")
    @post = Post.new
    @post.user = @user
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
