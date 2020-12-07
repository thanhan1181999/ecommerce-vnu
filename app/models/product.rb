class Product < ApplicationRecord
  belongs_to :category
  has_many :carts, dependent: :destroy
  has_one :sale, dependent: :destroy
  has_many :orders, dependent: :destroy
  belongs_to :store

  has_many_attached :images

end
