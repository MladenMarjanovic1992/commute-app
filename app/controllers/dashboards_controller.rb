class DashboardsController < ApplicationController
  def index
  end
  
  def search
    if params[:origin_city].empty? or params[:destination_city].empty?
      flash.now[:danger] = "Both search fields must be filled!"
      render :index
    else
      @rides = Ride.search_from_to(params[:origin_city], params[:destination_city])
    end
  end

end
