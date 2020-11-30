class Category < ApplicationRecord
  scope :has_attached_image, -> { joins(image_attachment: :blob) }
  
  has_many:products
  has_one_attached :image
end
