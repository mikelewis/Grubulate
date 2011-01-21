class IngredientsController < ApplicationController
  def index
    if params[:term].nil?
      render :text => "" and return
    end
    @ingredients = Ingredient.where("ingredients.name LIKE :query", {:query => "#{params[:term]}%"}).limit(10)
    render :json => @ingredients.to_json
  end

end
