class RenameFromToOriginCity < ActiveRecord::Migration[5.0]
  def change
    rename_column :rides, :from, :origin_city
  end
end
