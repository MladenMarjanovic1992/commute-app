class AddRideTimeToRides < ActiveRecord::Migration[5.0]
  def change
    add_column :rides, :ride_time, :time
  end
end
