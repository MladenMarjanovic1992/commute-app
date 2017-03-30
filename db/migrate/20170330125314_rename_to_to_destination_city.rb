class RenameToToDestinationCity < ActiveRecord::Migration[5.0]
  def change
    rename_column :rides, :to, :destination_city
  end
end
