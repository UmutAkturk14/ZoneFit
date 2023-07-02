class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :cookbook, :uncookbook, :destroy]

  def index
    @r = policy_scope(Recipe)
    @recipes = Recipe.page(params[:page]).per(20)
  end

  def show
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
    @recipe.user = current_user
    authorize @recipe
  end

  def update
    authorize @recipe
    if @recipe.update(recipe_params)
      flash[:notice] = "Your recipe has been updated"
      redirect_to @recipe
    else
      redirect_to :edit
    end
  end

  def cookbook
    authorize @recipe
    if current_user.favorited?(@recipe, scope: :cookbook)
      if current_user.unfavorite(@recipe, scope: :cookbook)
        flash[:notice] = "You have successfully removed this recipe to your cookbook"
        redirect_to @recipe
        return
      end
    else
      current_user.favorite(@recipe, scope: :cookbook)
      flash[:notice] = "You have successfully added this recipe to your cookbook"
      redirect_to @recipe
      return
    end
  end

  def destroy
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

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :instructions, :url, :prep_time, :difficulty, :ingredients)
  end
end
