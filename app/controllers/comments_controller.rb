class CommentsController < ApplicationController
  before_filter :authenticate_user!, :except => :index
  before_filter :setup
  def index
    @comments = @recipe.comments
  end

  def create
    comment = @recipe.add_comment(params[:comment].merge({:profile_id => current_profile.id}))
    if !comment.valid?
      flash[:invalid_comment] = comment
    end
    redirect_to @recipe
  end

  def destroy
    comment = @recipe.comments.find(params[:id], :conditions => {:profile_id => current_profile.id})
    comment.destroy
    redirect_to @recipe
  end

  private
  def setup
    @recipe = Recipe.find(params[:recipe_id])
  end
end
