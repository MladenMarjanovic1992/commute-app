class User < ApplicationRecord
  has_many :rides
  has_one :car
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates_presence_of :name
  validates_presence_of :image
  validates_presence_of :about_me
  
  acts_as_messageable
  ratyrate_rateable "rating"
  ratyrate_rater

  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  
  def has_image?
    image != nil
  end
  
  def has_car?
    car != nil
  end
  
  def mailboxer_email(object)
    email
  end
  
  def first_name
    self.name.split[0]
  end
  
end
