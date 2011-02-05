class FavoritesController < ApplicationController
  before_filter :authenticate_user!, :except => :index
  before_filter :setup

  def index
    @favorite_chefs = @profile.favorite_chefs
  end

  def create
    current_profile.add_favorite_chef(@profile)
    redirect_to @profile
  end

  def destroy
    current_profile.remove_favorite_chef(@profile)
    redirect_to @profile
  end

  private

  def setup
    @profile = Profile.find(params[:profile_id])
  end
end
