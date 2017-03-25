class Ride < ApplicationRecord
  belongs_to :user
  
  validates :from, presence: true
  validates :to, presence: true
  validates :seats, presence: true
  validates :ride_date, presence: true
  validates :ride_time, presence: true
  validates :details, presence: true

end
