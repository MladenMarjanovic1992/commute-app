class Ride < ApplicationRecord
  belongs_to :user, dependent: :destroy
  
  validates_presence_of :origin_city, :destination_city, :seats, :ride_date, :ride_time, :details, :price
  validates :price, numericality: {greater_than_or_equal_to: 0, only_integer: true}
  
  scope :origin_city, -> (origin_city) { where origin_city: origin_city.split(" ").map(&:capitalize!).join(" ") }
  scope :destination_city, -> (destination_city) { where destination_city: destination_city.split(" ").map(&:capitalize!).join(" ") }
  scope :ride_date, -> (ride_date) { where ride_date: ride_date}
  scope :price, -> (price) { where price: price}

  def just_time
    ride_time.to_s[11..15] + " h"
  end
  
  def normal_date
    ride_date.strftime("%d-%m-%Y")
  end

  def self.max_price
    maximum(:price)
  end

end
