class Ride < ApplicationRecord
  belongs_to :user
  
  validates :from, presence: true
  validates :to, presence: true
  validates :seats, presence: true
  validates :ride_date, presence: true
  validates :ride_time, presence: true
  validates :details, presence: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0, only_integer: true}
  
  def just_time
    self.ride_time.to_s[11..15] + " h"
  end

end
