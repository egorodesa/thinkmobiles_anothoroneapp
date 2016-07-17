class Car < ActiveRecord::Base

  monetize :price_kopiykas

  has_many :car_images, dependent: :destroy
  accepts_nested_attributes_for :car_images


end
