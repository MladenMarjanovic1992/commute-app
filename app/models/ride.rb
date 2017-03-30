class Ride < ApplicationRecord
  belongs_to :user, dependent: :destroy
  
  validates :origin_city, presence: true
  validates :destination_city, presence: true
  validates :seats, presence: true
  validates :ride_date, presence: true
  validates :ride_time, presence: true
  validates :details, presence: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0, only_integer: true}
  
  def just_time
    ride_time.to_s[11..15] + " h"
  end
  
  def normal_date
    ride_date.strftime("%d-%m-%Y")
  end
  
  def self.search_from_to(origin, destination)

    origin = origin.split(" ").map(&:capitalize!).join(" ")
    destination = destination.split(" ").map(&:capitalize!).join(" ")

    where("origin_city = ? and destination_city = ?", "#{origin}", "#{destination}")

  end

end
