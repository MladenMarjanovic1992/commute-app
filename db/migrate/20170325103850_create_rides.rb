class CreateRides < ActiveRecord::Migration[5.0]
  def change
    create_table :rides do |t|
      t.string :from
      t.string :to
      t.date :ride_date
      t.integer :seats
      t.text :details
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
