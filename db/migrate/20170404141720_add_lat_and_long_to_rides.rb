class AddLatAndLongToRides < ActiveRecord::Migration[5.0]
  def change
    add_column :rides, :lat_origin, :float
    add_column :rides, :long_origin, :float
    add_column :rides, :lat_destination, :float
    add_column :rides, :long_destination, :float
  end
end
