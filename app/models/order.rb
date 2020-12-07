class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :comment, dependent: :destroy
  has_one :store, through: :product
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  # QUERY = " orders.*,
  #           products.name as product_name,
  #           products.image as product_image,
  #           orders.quantity*products.price as total_price,
  #           products.store_id as store_id
  #         "

  # default_scope { joins(:product).select(QUERY) }

  def as_json(_options = {})
    pro = self.product
    attrs = self.attributes
    attrs[:product_name] = pro.name
    attrs[:store_id] = pro.store_id
    attrs[:total_price] = pro.price * self.quantity
    attrs[:product_images] = get_url_images(pro)
    attrs
  end
end
