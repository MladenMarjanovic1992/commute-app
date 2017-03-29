class Car < ApplicationRecord
  belongs_to :user
  
  validates :car_name, presence: true
  validates :car_image, presence: true
  
  has_attached_file :car_image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment_content_type :car_image, content_type: /\Aimage\/.*\z/
end
