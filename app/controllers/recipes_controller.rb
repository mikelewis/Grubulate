class RecipesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  def index
    @recipes = Recipe.search(params[:page])
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @entrees = Entree.all
  end

  def create
    params[:recipe][:entree_ids] ||= []
    params[:ingredients] ||= ""
    params[:recipe][:ingredient_ids] = Ingredient.names_to_ids(
      params[:ingredients].strip.split(',').map{|e| e.strip}
    )
    @recipe = Recipe.new(params[:recipe])
    @recipe.cook_time.to_i
    if current_profile.create_recipe(@recipe)
      redirect_to(@recipe)
    else
      @entrees = Entree.all
      flash[:entrees] = params[:recipe][:entree_ids]
      flash[:ingredients] = params[:ingredients].strip
      render :action => :new
    end
  end

  def edit
    @recipe = current_profile.recipes.find(params[:id])
    @entrees = Entree.all
  end

  def update
    params[:recipe][:entree_ids] ||= []
    params[:ingredients] ||= ""
    params[:recipe][:ingredient_ids] = Ingredient.names_to_ids(
      params[:ingredients].strip.split(',').map{|e| e.strip}
    )

    @recipe = current_profile.recipes.find(params[:id])
    if @recipe.update_attributes(params[:recipe])
      redirect_to(@recipe)
    else
      @entrees = Entree.all
      flash[:ingredients] = params[:ingredients].strip
      flash[:entrees] = params[:recipe][:entree_ids]
      render :action => "edit"
    end
  end

  def destroy
    @recipe = current_profile.recipes.find(params[:id])
    @recipe.destroy

    redirect_to(recipes_path)
  end

  private

end
