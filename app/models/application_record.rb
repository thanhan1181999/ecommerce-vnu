class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def get_url_images(pro)
    rs = []
    return unless pro.images.attached?

    pro.images.each do |x|
      rs << Rails.application.routes.url_helpers.url_for(x)
    end
    rs
  end

  def get_url_image(pro)
    return unless pro.image.attached?

    Rails.application.routes.url_helpers.url_for(pro.image)
  end
end
