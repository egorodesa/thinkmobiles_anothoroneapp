class AddAttachmentPhotoToCarImages < ActiveRecord::Migration
  def self.up
    change_table :car_images do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :car_images, :photo
  end
end
