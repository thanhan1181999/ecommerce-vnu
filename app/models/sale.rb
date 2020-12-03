class Sale < ApplicationRecord
  belongs_to :product

  QUERY = " sales.*,
            products.name as product_name,
            products.image as product_image,
            products.store_id as store_id
          ".freeze

  default_scope { joins(:product).select(QUERY) }
end
