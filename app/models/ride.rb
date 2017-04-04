class Ride < ApplicationRecord
  belongs_to :user, dependent: :destroy
  geocoded_by :origin_city, latitude: :lat_origin, longitude: :long_origin
  geocoded_by :destination_city, latitude: :lat_destination, longitude: :long_destination
  
  before_save :geocode_endpoints
  
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
  
  

  private

  def geocode_endpoints
    if origin_city_changed?
      geocoded = Geocoder.search(origin_city).first
      if geocoded
        self.lat_origin = geocoded.latitude
        self.long_origin = geocoded.longitude
      end
    end

    if destination_city_changed?
      geocoded = Geocoder.search(destination_city).first
      if geocoded
        self.lat_destination = geocoded.latitude
        self.long_destination = geocoded.longitude
      end
    end
  end

end
