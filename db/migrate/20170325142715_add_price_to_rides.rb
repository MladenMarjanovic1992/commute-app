class AddPriceToRides < ActiveRecord::Migration[5.0]
  def change
    add_column :rides, :price, :integer
  end
end
