class DriversController < ApplicationController
  def show
    @driver = User.find(params[:id])
  end
end
