class User < ApplicationRecord
  has_many :rides
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  
  def has_image?
    image != nil
  end
  

end
