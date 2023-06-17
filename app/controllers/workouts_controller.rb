class WorkoutsController < ApplicationController
  def index
    @workouts = policy_scope(Workout)
  end

  def show
    @workout = Workout.find(params[:id])
    authorize @workout
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

  def workout_params
    params.require(:workout).permit(:title, :description, :url, :difficulty, :muscle_group)
  end
end
