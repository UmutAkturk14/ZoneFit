class WorkoutsController < ApplicationController
  def index
    @workouts = policy_scope(Workout)
  end

  def show
    @workout = Workout.find(params[:id])
    authorize @workout
  end

end
