class Product < ApplicationRecord
  belongs_to :category
  has_many :carts, dependent: :destroy
  has_one :sale
  has_many :orders
  belongs_to :store
end
