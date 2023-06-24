class PagesController < ApplicationController
  def home
    recipes = Recipe.all
    @top_recipes = []
    4.times do |_|
      sampled_items = recipes.sample
      @top_recipes << sampled_items
    end
    workouts = Workout.all
    @top_workouts = []
    4.times do |_|
      sampled_works = workouts.sample
      @top_workouts << sampled_works
    end
  end
end
