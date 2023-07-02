class PagesController < ApplicationController
  before_action :authenticate_user!, except: :landing

  def home
    @posts = policy_scope(Post).order(updated_at: :desc)
    @post = Post.new
    @comment = Comment.new
    @user = current_user
  end

  def landing
    if current_user
      redirect_to home_path
    end
  end
end
