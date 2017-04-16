class DriversController < ApplicationController
  def show
    @driver = User.find(params[:id])
    @rides = @driver.rides.page(params[:page]).per(3)
  end
end
