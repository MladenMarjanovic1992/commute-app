class DashboardsController < ApplicationController
  def index
  end
=begin  
  def search
    if params[:origin_city].empty? or params[:destination_city].empty?
      flash.now[:danger] = "Both search fields must be filled!"
      render :index
    else
      @rides = Ride.search_from_to(params[:origin_city], params[:destination_city])
      @origin = params[:origin_city].split(" ").map(&:capitalize).join(" ")
      @destination = params[:destination_city].split(" ").map(&:capitalize).join(" ")
    end
  end
=end

  #params[:price] = params[:price_from]..params[:price_to]
  
  def search
    params[:price] = params[:price_from]..params[:price_to] if (params[:price_from].present? && params[:price_to].present?)
    @max_price = Ride.max_price
    @rides = Ride.where(nil)
    search_params(params).each do |method, param|
      @rides = @rides.public_send(method, param) if param.present?
    end
  end
  
  private
  
  def search_params(params)
    params.slice(:origin_city, :destination_city, :ride_date, :price)
  end

end
