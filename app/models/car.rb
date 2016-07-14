class Car < ActiveRecord::Base

  monetize :price_kopiykas

  has_many :car_images
  accepts_nested_attributes_to :car_images

end
