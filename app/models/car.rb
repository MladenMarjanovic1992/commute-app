class Car < ApplicationRecord
  belongs_to :user
  
  validates_presence_of :car_name, :car_image
  
  has_attached_file :car_image, styles: { large: "200x133" }
  validates_attachment_content_type :car_image, content_type: /\Aimage\/.*\z/
end
