class PagesController < ApplicationController
  before_action :authenticate_user!, except: :landing

  def home
    @posts = policy_scope(Post).order(updated_at: :desc)
    @post = Post.new
    @comment = Comment.new
    @user = current_user
    @workouts = Workout.all
    @recipes = Recipe.all
    # if params[:query].present?
    #   @results = PgSearch.multisearch(params[:query])
    #   redirect_to workouts_path()
    # end
  end

  def landing
    if current_user
      redirect_to home_path
    end
  end

  def friends
    @f = policy_scope(User)
    @user = current_user
    # TODO: Pending friend requests sent by me
    # @pending_requests = @user.follow_requests
    @pending_requests = @user.follow_requests
    # TODO: Pending friend requests came to me
    @pending_requests_came = @user.pending_requests
    # TODO: All friends
    @friends = @user.followers & @user.following
  end

  def search
    @workouts = Workout.all
    @recipes = Recipe.all
    if params[:query].present?
      @results = PgSearch.multisearch(params[:query])
    end
  end
end
