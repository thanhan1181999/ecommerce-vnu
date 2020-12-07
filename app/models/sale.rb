class Sale < ApplicationRecord
  belongs_to :product

  # QUERY = " sales.*,
  #           products.name as product_name,
  #           products.image as product_image,
  #           products.store_id as store_id
  #         ".freeze

  # default_scope { joins(:product).select(QUERY) }

  def as_json(_options = {})
    pro = self.product
    attrs = self.attributes
    attrs[:product_name] = pro.name
    attrs[:store_id] = pro.store_id
    attrs[:product_images] = get_url_images(pro)
    attrs
  end
end
