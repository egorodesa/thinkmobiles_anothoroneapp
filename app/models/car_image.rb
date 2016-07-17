class CarImage < ActiveRecord::Base
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" },
                     default_url: "/images/:style/missing.png",
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                    :dropbox_options => {:path => proc { |style| "#{style}/#{id}_#{picture.original_filename}"},
                    :unique_filename => true  }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  belongs_to :car

  def self.upload_image(id,car_id)
#     Rails.logger.debug "pricessing started"

#     p = CarImage.find(id)
#     path = p.temp_file_path
#     p.photo = File.new(path, 'rb')
#     p.temp_file_path = nil
#     p.car_id = car_id
#     p.save
# # binding.pry
#     FileUtils.remove_file(path)

#     Rails.logger.debug "pricessing finished"
  end

end
