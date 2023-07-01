class PagesController < ApplicationController
  def home
    @posts = policy_scope(Post).order(updated_at: :desc)
    @post = Post.new
    @comment = Comment.new
    @user = current_user
  end
end
