class Store < ApplicationRecord
  belongs_to :users
  has_many :products
  has_many :orders, through: :products
  has_one_attached :image
  has_many :sales, through: :products
end
