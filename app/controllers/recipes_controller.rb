class RecipesController < ApplicationController
  def index
    @recipes = policy_scope(Recipe)
  end

  def show
    @recipe = Recipe.find(params[:id])
    authorize @recipe
    recipes = Recipe.all
    @top_recipes = []
    4.times do |_|
      sampled_items = recipes.sample
      @top_recipes << sampled_items
    end
  end
end
