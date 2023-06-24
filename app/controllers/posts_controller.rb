class PostsController < ApplicationController
  def new
    @post = Post.new
    @post.user = current_user
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    authorize @post
    if @post.save!
      redirect_back(fallback_location: root_path)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post
    if @post.destroy
      flash[:notice] = "Post has been successfully deleted."
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
