class FastImageUploadJob < ActiveJob::Base
  queue_as :default

  def perform(pic_id,car_id)

   # CarImage.upload_image(pic_id,car_id)

    # Do something later

    Rails.logger.debug "pricessing started"

    p = CarImage.find(pic_id)
    path = p.temp_file_path
    p.photo = File.new(path, 'rb')
    p.temp_file_path = nil
    p.car_id = car_id
    p.save
# binding.pry
    FileUtils.remove_file(path)

    Rails.logger.debug "pricessing finished"
  end
end
