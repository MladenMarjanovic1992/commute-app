class DashboardsController < ApplicationController

  def index
  end
  
  def search
    params[:price] = params[:price_from]..params[:price_to] if (params[:price_from].present? && params[:price_to].present?)
    @max_price = Ride.max_price
    @rides = Ride.includes(:user, :car).order(ride_date: :asc, ride_time: :asc).page params[:page]
    search_params(params).each do |method, param|
      @rides = @rides.public_send(method, param) if param.present?
    end
    session[:search_results] = request.url
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  private
  
  def search_params(params)
    params.slice(:origin_city, :destination_city, :ride_date, :price)
  end

end
