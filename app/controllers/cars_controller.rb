class CarsController < ApplicationController
  before_action :authenticate_user!
  
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
  
  def edit
    @car = current_user.car
  end
  
  def update
    @car = current_user.car
    
    if @car.update(car_params)
      flash[:notice] = "Car updated!"
      redirect_to drivers_show_path(id: current_user.id)
    else
      flash.now[:danger] = "Car not updated!"
      render :edit
    end
  end
  
  def destroy
    @car = current_user.car
    
    @car.destroy
    redirect_to drivers_show_path(id: current_user.id)
    flash[:notice] = "Car deleted!"
  end
  
  private 
  
    def car_params
      params.require(:car).permit(:car_name, :car_image)
    end
end
