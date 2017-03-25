class RidesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :find_ride, only: [:show, :edit, :update, :destroy]
  
  def index
  end

  def show
  
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
  end

  def destroy
  end
  
  private
  
    def find_ride
      @ride = current_user.rides.find(params[:id])
    end
    
    def ride_params
      params.require(:ride).permit(:from, :to, :seats, :ride_date, :ride_time, :details)
    end
    
end