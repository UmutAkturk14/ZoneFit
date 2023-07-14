class WorkoutsController < ApplicationController
  def index
    @w = policy_scope(Workout)
    @workout = Workout.new

    if params[:title].present? || params[:style].present? || params[:equipment].present?
      if params[:title].present? && params[:style].present? && params[:equipment].present?
        @workouts = Workout.search_by_title_and_description_and_tag(params[:title]) + Workout.search_by_title_and_description_and_tag(params[:style]) + Workout.search_by_title_and_description_and_tag(params[:equipment])
      elsif params[:title].present? && params[:style].present?
        @workouts = Workout.search_by_title_and_description_and_tag(params[:title]) + Workout.search_by_title_and_description_and_tag(params[:style])
      elsif params[:title].present? && params[:equipment].present?
        @workouts = Workout.search_by_title_and_description_and_tag(params[:title]) + Workout.search_by_title_and_description_and_tag(params[:equipment])
      elsif params[:style].present? && params[:equipment].present?
        @workouts = Workout.search_by_title_and_description_and_tag(params[:style]) + Workout.search_by_title_and_description_and_tag(params[:equipment])
      elsif params[:title].present?
        @workouts = Workout.search_by_title_and_description_and_tag(params[:title])
      elsif params[:style].present?
        @workouts = Workout.search_by_title_and_description_and_tag(params[:style])
      elsif params[:equipment].present?
        @workouts = Workout.search_by_title_and_description_and_tag(params[:equipment])
      end
    else
      @workouts = Workout.page(params[:page]).per(20)
    end

    unless @workouts == Workout.page(params[:page]).per(20)
      @workouts = @workouts.page(params[:page]).per(20)
    end
  end

  def show
    @workout = Workout.find(params[:id])
    authorize @workout
    @comments = Comment.where(commentable: @workout)
    @comment = Comment.new
    @commentable = @workout
    @post = Post.new
    unless @workout.tag.nil?
      @tags = @workout.tag.gsub!("\"", "").gsub!("[", "").gsub!("]", "").split(",")
    end
  end

  def new
    @workout = Workout.new
    @workout.user = current_user
    authorize @workout
  end

  def create
    @workout = Workout.new(workout_params)
    @workout.user = current_user
    authorize @workout
    if @workout.save!
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def watchlist
    @workout = Workout.find(params[:id])
    authorize @workout
    if current_user.favorited?(@workout, scope: :watchlist)
      if current_user.unfavorite(@workout, scope: :watchlist)
        flash[:notice] = "You have successfully removed this workout to your watchlist"
        redirect_to @workout
        return
      end
    else
      current_user.favorite(@workout, scope: :watchlist)
      flash[:notice] = "You have successfully added this recipe to your watchlist"
      redirect_to @workout
      return
    end
  end

  def favorite
    @workout = Workout.find(params[:id])
    authorize @workout
    if current_user.favorited?(@workout)
      if current_user.unfavorite(@workout)
        flash[:notice] = "You have successfully removed this workout to your favorites"
        redirect_to @workout
        return
      end
    else
      current_user.favorite(@workout)
      flash[:notice] = "You have successfully added this recipe to your favorites"
      redirect_to @workout
      return
    end
  end

  private

  def workout_params
    params.require(:workout).permit(:title, :description, :url, :difficulty, :muscle_group, :style, :equipment)
  end
end
