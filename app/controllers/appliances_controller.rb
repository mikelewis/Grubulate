class AppliancesController < ApplicationController
  def index
    if params[:term].nil?
      render :text => "" and return
    end
    @appliances = Appliance.where("appliances.name LIKE :query", {:query => "#{params[:term]}%"}).limit(10)
    render :json => @appliances.to_json

  end

end
