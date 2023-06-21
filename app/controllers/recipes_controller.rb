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

  def new
    @recipe = Recipe.new
    authorize @recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    authorize @recipe
    if @recipe.save!
      flash[:notice] = "Your recipe has been added for others to enjoy!"
      redirect_to recipes_path
    else
      render :new, status: :unprocessible_entity
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :instructions, :url, :prep_time, :difficulty, :ingredients)
  end
end
