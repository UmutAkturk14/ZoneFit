class WorkoutsController < ApplicationController
  def index
    @workouts = policy_scope(Workout)
  end

end
