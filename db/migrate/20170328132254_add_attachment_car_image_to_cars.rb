class AddAttachmentCarImageToCars < ActiveRecord::Migration
  def self.up
    change_table :cars do |t|
      t.attachment :car_image
    end
  end

  def self.down
    remove_attachment :cars, :car_image
  end
end
