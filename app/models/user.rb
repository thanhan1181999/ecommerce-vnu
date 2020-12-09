class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :orders, dependent: :destroy
  has_one :store
  has_many :carts, dependent: :destroy

  has_one_attached :image

  def as_json(_options = {})
    res = {}
    res[:id] = self.id
    res[:name] = self.name
    res[:email] = self.email
    res[:image] = get_url_image(self)
    res[:gender] = self.gender
    res[:address] = self.address
    res[:role] = self.role
    res[:jti] = self.jti
    res
  end
end
