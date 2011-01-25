class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :except => :show
  def show
    @profile = current_profile
    @profile_displayed = Profile.find(params[:id])
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
