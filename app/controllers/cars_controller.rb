class CarsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def new
    @car = current_user.build_car
  end

  def create
    @car = current_user.build_car(car_params)
    
    if @car.save
      flash[:notice] = "Car successfully added!"
      redirect_to drivers_show_path(id: current_user.id)
    else
      flash.now[:danger] = "Car not added!"
      render :new
    end
  end
  
  private 
  
    def car_params
      params.require(:car).permit(:car_name, :car_image)
    end
end
