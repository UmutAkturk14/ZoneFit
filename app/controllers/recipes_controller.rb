class RecipesController < ApplicationController
  def index
    @r = policy_scope(Recipe)
    @recipes = Recipe.page(params[:page]).per(20)
  end

  def show
    @recipe = Recipe.find(params[:id])
    authorize @recipe
    @comments = Comment.where(commentable: @recipe)
    @comment = Comment.new
    @commentable = @recipe
    @post = Post.new
    @top_recipes = Recipe.all.sample(4)
    @ingredients = @recipe.ingredients.split(",")
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

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe.user = current_user
    authorize @recipe
  end

  def update
    @recipe = Recipe.find(params[:id])
    authorize @recipe
    if @recipe.update(recipe_params)
      flash[:notice] = "Your recipe has been updated"
      redirect_to @recipe
    else
      redirect_to :edit
    end

  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.user = current_user
    authorize @recipe
    if @recipe.destroy
      Comment.where(commentable: @recipe).delete_all
      flash[:notice] = "Your recipe has been deleted"
      redirect_to recipes_path(@recipes)
    end
  end

  def search_ingredients
    query = params[:query]
    @results = Ingredient.search_nutrition(query)

    respond_to do |format|
      format.js
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :instructions, :url, :prep_time, :difficulty, :ingredients)
  end
end
