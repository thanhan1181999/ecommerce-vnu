
class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :comment
  has_one :store, through: :product

  QUERY = " orders.*, 
            products.name as product_name,
            products.image as product_image,
            orders.quantity*products.price as total_price,
            products.store_id as store_id
          " 

  default_scope { joins(:product).select(QUERY) }

end
