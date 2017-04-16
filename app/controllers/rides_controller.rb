class RidesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :find_ride, only: [:edit, :update, :destroy]
  before_action :has_car?, only: :new

  def show
    @ride = Ride.find(params[:id])
    @driver = @ride.user
    @car = @ride.car
  end
  
  def new
    @ride = current_user.rides.new
  end

  def create
    @ride = current_user.rides.new(ride_params)
    
    if @ride.save
      flash[:notice] = "Your ride has been created"
      redirect_to [current_user, @ride]
    else
      flash.now[:danger] = "Your ride has not been created"
      render :new
    end
  end

  def edit
  end

  def update
    if @ride.update(ride_params)
      flash[:notice] = "Ride successfully updated!"
      redirect_to [current_user, @ride]
    else
      flash.now[:danger] = "Ride has not been updated!"
      render :edit
    end
  end

  def destroy
    @ride.destroy
    flash[:notice] = "Ride has been deleted!"
    redirect_to root_path
  end
  
  private
  
    def has_car?
      unless current_user.has_car?
        flash[:alert] = "You must add a car before posting a ride"
        redirect_to controller: :cars, action: :new
      end
    end
  
    def find_ride
      @ride = current_user.rides.find(params[:id])
    end
    
    def ride_params
      params.require(:ride).permit(:origin_city, :destination_city, :seats, :ride_date, :ride_time, :details, :price)
    end
    
end
