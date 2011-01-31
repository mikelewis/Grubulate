class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :except => :show
  def show
    @profile_displayed = Profile.find(params[:id])
    @recipes = Recipe.get_by_profile(params[:page], @profile_displayed)
  end

  def edit
    @profile = current_profile
  end

  def update
    @profile = current_profile
    if @profile.update_attributes(params[:profile])
        redirect_to(@profile)
    else
      render :action => "edit"
    end
  end

end
