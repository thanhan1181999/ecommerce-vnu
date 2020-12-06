include Rails.application.routes.url_helpers
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def get_url_images(pro)
    rs = []
    return unless pro.images.attached?

    pro.images.each do |x|
      rs << url_for(x)
    end
    rs
  end
end
