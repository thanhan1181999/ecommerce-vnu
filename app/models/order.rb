
class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :comment
  
  QUERY = " orders.id,
            orders.product_id, 
            products.name as product_name,
            orders.quantity,
            products.picture as product_picture,
            orders.quantity*products.price as total_price
          " 

  scope :add,-> { joins(:product).select(QUERY) }

  def export
    Order.add.find(self.id)
  end

  def self.export(user)
    user.orders.add
  end
end
