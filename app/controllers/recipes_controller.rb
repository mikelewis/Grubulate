class RecipesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  def index

    params[:search]["ingredients_name_equals_any"] = params[:ingredients].strip.split(',').map{|e| e.strip} if params[:ingredients]
    params[:search]["appliances_name_equals_any"] = params[:appliances].strip.split(',').map{|e| e.strip} if params[:appliances]
    
    flash[:search_ingredients] = params[:ingredients].strip if params[:ingredients]
    flash[:search_appliances] = params[:appliances].strip if params[:appliances]
    @search = Recipe.search(params[:search])
    pagination_args = {:page => params[:page], :include => [:profile]}
    pagination_args[:order] = "recipes.created_at DESC" if params[:meta_sort]
    @recipes = @search.relation.select("DISTINCT(recipes.id), recipes.*").paginate pagination_args

  end

  def show
    @recipe = Recipe.find(params[:id], :include => :most_recent_comments)
    @comment = Comment.new
  end

  def new
    @recipe = Recipe.new
    @entrees = Entree.all
  end

  def create
    params[:recipe][:entree_ids] ||= []
    params[:ingredients] ||= ""
    params[:appliances] ||= ""
    params[:recipe][:appliance_ids] = Appliance.names_to_ids(
      params[:appliances].strip.split(',').map{|e| e.strip}
    )
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
      flash[:appliances] = params[:appliances].strip
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
    params[:appliances] ||= ""
    params[:recipe][:appliance_ids] = Appliance.names_to_ids(
      params[:appliances].strip.split(',').map{|e| e.strip}
    )
    params[:recipe][:ingredient_ids] = Ingredient.names_to_ids(
      params[:ingredients].strip.split(',').map{|e| e.strip}
    )

    @recipe = current_profile.recipes.find(params[:id])
    if @recipe.update_attributes(params[:recipe])
      redirect_to(@recipe)
    else
      @entrees = Entree.all
      flash[:ingredients] = params[:ingredients].strip
      flash[:appliances] = params[:appliances].strip
      flash[:entrees] = params[:recipe][:entree_ids]
      render :action => "edit"
    end
  end

  def destroy
    @recipe = current_profile.recipes.find(params[:id])
    @recipe.destroy

    redirect_to(recipes_path)
  end

  def rate
    @recipe = Recipe.find(params[:id])
    @recipe.rate(params[:stars], current_profile)
    #render do |page|
      #render :text => ratings_for(@recipe).to_yaml
     # page.replace_html @recipe.wrapper_dom_id(params), ratings_for(@recipe, params.merge(:wrap => false))
     # page.visual_effect :highlight, @recipe.wrapper_dom_id(params)
    #end
    
  end

  private

end
