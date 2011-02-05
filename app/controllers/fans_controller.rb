class FansController < ApplicationController
  before_filter :setup
  def index
    @fans = @profile.fans
  end

  private
  def setup
    @profile = Profile.find(params[:profile_id])
  end
end
